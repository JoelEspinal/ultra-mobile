import 'package:dartz/dartz.dart';

import '../../entities/todo.dart';
import '../../../common/failures/failure.dart';
import '../../repositories/local_todo_repository.dart'
    show LocalPersistenceRepository;

class DeleteTodoUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  DeleteTodoUseCase({
    required this.localPersistenceRepository,
  });

  Future<Either<Failure, Todo?>> execute(int id) async {
    try {
      await localPersistenceRepository.deleteTodo(id);

      return Future.value(Right(null));
    } catch (e) {
      return Left(
          ServerFailure('Failed to delete todo with id: $id, error: $e'));
    }
  }
}
