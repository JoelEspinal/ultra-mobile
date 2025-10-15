import 'package:dartz/dartz.dart';

import '../network/error_handler.dart';
import '../network/todos_api/models/todo.dart';
import '../network/todos_api/services/todo_service.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoService todoService;

  TodoRepositoryImpl({required this.todoService});

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todosResponse = await todoService.fetchTodos();
      return Right(todosResponse.todos);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(int id) {
    throw UnimplementedError();
  }
}
