import 'package:dartz/dartz.dart';

import '../../domain/entities/todo.dart' as todo_entity;
import '../network/todos_api/models/todo.dart';

import '../network/error_handler.dart';
import '../network/todos_api/services/todo_service.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoService todoService;

  TodoRepositoryImpl({required this.todoService});

  @override
  Future<Either<Failure, List<todo_entity.Todo>>> getTodos() async {
    try {
      final todosResponse = await todoService.fetchTodos();
      final todoEntities = todosResponse.todos
          .map(
            (t) => todo_entity.Todo(
              id: t.id,
              todo: t.todo,
              completed: t.completed,
              userId: t.userId,
            ),
          )
          .toList();

      return Right(todoEntities);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, todo_entity.Todo>> getTodo(int id) async {
    try {
      final todo = await todoService.fetchTodo(id);
      final todoEntity = todo.map(
        (t) => todo_entity.Todo(
          id: t.id,
          todo: t.todo,
          completed: t.completed,
          userId: t.userId,
        ),
      );

      return Right(todoEntity);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, todo_entity.Todo?>> delete(int id) async {
    try {
      final todo = await todoService.deleteTodo(id);
      if (todo == null) {
        return Right(null);
      }

      final todoEntity = todo.map(
        (t) => todo_entity.Todo(
          id: t.id,
          todo: t.todo,
          completed: t.completed,
          userId: t.userId,
        ),
      );

      return Right(todoEntity);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, todo_entity.Todo?>> updateTodo(
    todo_entity.Todo toUpdteTodo,
  ) async {
    try {
      final Todo todo = toUpdteTodo.map(
        (t) => Todo(
          id: t.id,
          todo: t.todo,
          completed: t.completed,
          userId: t.userId,
        ),
      );

      final updatedTodo = await todoService.updateTodo(todo);

      if (updatedTodo == null) return Right(null);

      final todoEntity = updatedTodo.map(
        (t) => todo_entity.Todo(
          id: t.id,
          todo: t.todo,
          completed: t.completed,
          userId: t.userId,
        ),
      );

      return Right(todoEntity);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
