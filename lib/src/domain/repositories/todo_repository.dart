import 'package:dartz/dartz.dart';

import '../../domain/entities/todo.dart' as todo_entity;
import '../failures/failure.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<todo_entity.Todo>>> getTodos();
  Future<Either<Failure, todo_entity.Todo>> getTodo(int id);
  Future<Either<Failure, todo_entity.Todo?>> delete(int id);
  Future<Either<Failure, todo_entity.Todo?>> updateTodo(
    todo_entity.Todo toUpdteTodo,
  );
}
