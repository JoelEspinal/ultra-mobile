import 'package:dartz/dartz.dart';
import '../../data/database/hive/models/todo.dart' as todo_model;

import '../../common/failures/failure.dart';
import '../repositories/local_todo_repository.dart';
import '../repositories/remote_todo_repository.dart';

class SyncTodosUseCase {
  final RemoteTodoRepository remoteRepository;
  final LocalPersistenceRepository localPersistenceRepository;

  SyncTodosUseCase({
    required this.remoteRepository,
    required this.localPersistenceRepository,
  });

  Future<Either<Failure, void>> execute() async {
    try {
      // 1. Push Phase: Find all local items that need sync
      final localTodos = await localPersistenceRepository.getAllTodoModels();
      final itemsToPush = localTodos.where((todo) => todo.needsSync).toList();

      for (var localTodo in itemsToPush) {
        try {
          // Convert to domain entity for the remote repository
          final entity = localTodo.toEntity();
          await remoteRepository.updateTodo(entity);
          
          // If successful, reset needsSync flag locally
          final syncedModel = localTodo.copyWith(needsSync: false);
          await localPersistenceRepository.updateTodo(syncedModel);
        } catch (e) {
          // If a single item fails, log and continue with others
          print('Failed to push todo ${localTodo.id}: $e');
        }
      }

      // 2. Pull Phase: Fetch latest from remote
      final remoteTodosResult = await remoteRepository.getTodoRemoteList();
      
      if (remoteTodosResult.isNotEmpty) {
        // Simple merge: remote always wins for now, except for items currently being edited locally
        final localTodosAfterPush = await localPersistenceRepository.getAllTodoModels();
        
        for (var remoteEntity in remoteTodosResult) {
          final localMatch = localTodosAfterPush.cast<todo_model.Todo?>().firstWhere(
            (l) => l?.id == remoteEntity.id,
            orElse: () => null,
          );

          if (localMatch == null) {
            // New item from remote
            await localPersistenceRepository.addTodo(todo_model.Todo.fromTodoEntity(remoteEntity));
          } else if (!localMatch.needsSync) {
            // Existing item, not locally edited since last sync -> Update with remote data
            await localPersistenceRepository.updateTodo(todo_model.Todo.fromTodoEntity(remoteEntity));
          }
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
