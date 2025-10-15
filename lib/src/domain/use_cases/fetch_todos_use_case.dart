import 'package:dartz/dartz.dart';
import '../entities/todo.dart';
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class FetchTodosUseCase {
  // required api repository remote api

  final TodoRepository todoRepository;

  FetchTodosUseCase({required this.todoRepository});

  Future<Either<Failure, List<Todo>>> execute() async {
    final todos = await todoRepository.getTodos();
    return todos;
  }
}
