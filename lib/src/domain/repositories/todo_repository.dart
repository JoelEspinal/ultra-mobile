import 'package:dartz/dartz.dart';
import '../../domain/entities/todo.dart';
import '../failures/failure.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, Todo>> getTodo(int id);
}
