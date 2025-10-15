import 'package:dartz/dartz.dart';
import '../../data/network/todos_api/models/todo.dart';
import '../failures/failure.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
}
