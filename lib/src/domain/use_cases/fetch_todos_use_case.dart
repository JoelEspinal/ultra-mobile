import 'package:dartz/dartz.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class FetchTodosUseCase {
  // required api repository remote api

  final TodoRepository todoRepository;

  FetchTodosUseCase({required this.todoRepository});

  Future<Either<Failure, List<todo_entity.Todo>>> execute() async {
    final todos = await todoRepository.getTodos();
    return todos;
  }
}
