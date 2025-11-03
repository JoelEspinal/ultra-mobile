import 'package:dartz/dartz.dart';

import '../../../data/database/hive/models/todo.dart';
import '../../../domain/entities/todo.dart' as entity_todo;
import '../../failures/failure.dart';
import '../../repositories/local_todo_repository.dart';

class FetchLocalTodoUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  FetchLocalTodoUseCase({required this.localPersistenceRepository});

  Future<Either<Failure, List<entity_todo.Todo>>> execute() async {
    try {
      final localTodoModels =
          await localPersistenceRepository.getAllTodoModels();

      List<entity_todo.Todo> todoEntities = Todo.toEntityList(localTodoModels);

      return Future.value(Right(todoEntities));
    } catch (e) {
      return Future.value(
          Left(ServerFailure('Failed to fetch todos from Hive: $e')));
    }
  }
}
