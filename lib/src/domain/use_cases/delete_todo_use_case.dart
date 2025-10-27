import 'package:dartz/dartz.dart';
import '../entities/todo.dart';
import '../failures/failure.dart';
import '../repositories/remote_todo_repository.dart';

class DeleteTodoUseCase {
  final RemoteTodoRepository _remoteTodoRepository;

  DeleteTodoUseCase({required RemoteTodoRepository todoRepository})
      : _remoteTodoRepository = todoRepository;

  Future<Either<Failure, Todo?>> execute(int id) async {
    try {
      final todo = await _remoteTodoRepository.delete(id);
      todo == null
          ? Left(ServerFailure('Failed to delete todo with id: $id'))
          : Right(todo);

      return Future.value(Right(todo));
    } catch (e) {
      return Left(
          ServerFailure('Failed to delete todo with id: $id, error: $e'));
    }
  }
}
