import 'package:dartz/dartz.dart';

import '../entities/todo.dart';
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository todoRepository;

  DeleteTodoUseCase({required this.todoRepository});

  Future<Either<Failure, Todo?>> execute(int id) async {
    final todos = await todoRepository.delete(id);
    return todos;
  }
}
