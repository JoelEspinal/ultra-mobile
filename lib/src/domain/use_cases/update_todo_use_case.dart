import 'package:dartz/dartz.dart';
import 'package:ultra_mobile/src/data/database/hive/models/todo_model.dart';

import 'package:ultra_mobile/src/domain/repositories/persistence_repository.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';

class UpdateTodoUseCase {
  final PersistenceRepository persistenceRepository;

  UpdateTodoUseCase({required this.persistenceRepository});

  Future<Either<Failure, Unit>> execute(todo_entity.Todo toUpdateTodo) async {
    try {
//       // Validate todo before updating
      if (toUpdateTodo.todo.trim().isEmpty) {
        return Left(ValidationFailure());
      }

      TodoModel toUpdateTodoModel = TodoModel.fromEntity(toUpdateTodo);
      await persistenceRepository.updateTodo(toUpdateTodoModel);
      return Future.value(Right(unit));

      // return updatedTodo.fold<Either<Failure, todo_entity.Todo?>>(
      //   (left) => Left(mapExceptionToFailure(left)),
      //   (todo) => Right(todo),
      // );
    } catch (e) {
      return Left(ServerFailure('Failed to update todo: $e'));
    }
  }
}
