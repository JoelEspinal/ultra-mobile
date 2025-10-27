import 'package:dartz/dartz.dart';
import '../../data/database/hive/models/todo_model.dart';
import '../repositories/persistence_repository.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';
import '../repositories/remote_todo_repository.dart';

class FetchTodosUseCase {
  final RemoteTodoRepository remoteTodoRepository;
  final PersistenceRepository localPersistenceRepository;

  FetchTodosUseCase(
      {required this.localPersistenceRepository,
      required this.remoteTodoRepository});

  Future<Either<Failure, List<todo_entity.Todo>>> execute() async {
    // Try to get todos from local persistence first
    final localTodoModels = await localPersistenceRepository.getAllTodoModels();

    if (localTodoModels.isNotEmpty) {
      final localEntities =
          localTodoModels.map((model) => model.toEntity()).toList();
      return Right(localEntities);
    }

    // Fallback to remote repository when no local todos
    final remoteTodosResult = await remoteTodoRepository.getAll();

    if (remoteTodosResult.isNotEmpty) {
      final entityList =
          remoteTodosResult.map((t) => TodoModel.fromEntity(t)).toList();

      final todoIds =
          await localPersistenceRepository.saveTodoModelList(entityList);

      if (todoIds.isNotEmpty) {
        final allTodoModels =
            await localPersistenceRepository.getAllTodoModels();
        if (allTodoModels.isNotEmpty) {
          final allTodoModelsEntities =
              allTodoModels.map((model) => model.toEntity()).toList();
          return Future.value(Right(allTodoModelsEntities));
        } else {
          return Left(ServerFailure('Failed to save todos locally'));
        }
      } else {
        return Left(ServerFailure('Failed to save todos locally'));
      }
    }
    return Left(ServerFailure('No todos found'));
  }
}
