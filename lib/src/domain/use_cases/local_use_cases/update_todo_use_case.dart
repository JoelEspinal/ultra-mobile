import 'package:dartz/dartz.dart';

import '../../../data/database/hive/models/todo.dart';
import '../../entities/todo.dart' as todo_entity;
import '../../repositories/local_todo_repository.dart';
import '../../failures/failure.dart';

class UpdateTodoUseCase {
  final LocalPersistenceRepository persistenceRepository;

  UpdateTodoUseCase({required this.persistenceRepository});

  Future<Either<Failure, Unit>> execute(todo_entity.Todo todo) async {
    try {
      if (todo.todo.trim().isEmpty) {
        return Left(ValidationFailure());
      }

      final todoModel = Todo.fromTodoEntity(todo);
      await persistenceRepository.updateTodo(todoModel);
      return Future.value(Right(unit));
    } catch (e) {
      return Left(ServerFailure('Failed to update todo: $e'));
    }
  }
}
