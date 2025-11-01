import 'package:dartz/dartz.dart';
import '../entities/todo.dart' show Todo;
import '../../data/database/hive/models/todo_model.dart' as todo_model;

import '../failures/failure.dart';
import '../repositories/local_todo_repository.dart';
import '../repositories/remote_todo_repository.dart';

class SyncTodosUseCase {
  final RemoteTodoRepository remoteRepository;
  final LocalPersistenceRepository localPersistenceRepository;

  SyncTodosUseCase({
    required this.remoteRepository,
    required this.localPersistenceRepository,
  });

  Future<Either<Failure, List<int>>> execute() async {
    try {
      if (localPersistenceRepository.isBoxEmpty()) {
        final remoteTodosResult = await remoteRepository.getTodoRemoteList();

        final todoModelList =
            todo_model.Todo.toTodoModelList(remoteTodosResult);

        List<int> ids =
            await localPersistenceRepository.addTodoModelList(todoModelList);
        return Right(ids);
      }

      // If there is nothing to sync, return an empty list of created IDs.
      return Right(<int>[]);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
