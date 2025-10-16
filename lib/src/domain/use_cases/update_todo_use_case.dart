import 'package:dartz/dartz.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository todoRepository;

  UpdateTodoUseCase({required this.todoRepository});

  Future<Either<Failure, todo_entity.Todo?>> execute(
    todo_entity.Todo toUpdateTodo,
  ) async {
    final updatedTodo = await todoRepository.updateTodo(toUpdateTodo);

    return updatedTodo;
  }
}
