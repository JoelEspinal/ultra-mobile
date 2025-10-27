import 'package:dartz/dartz.dart';
import '../../data/database/hive/models/todo_model.dart';
import '../repositories/persistence_repository.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class FetchTodosUseCase {
  final TodoRepository todoRepository;
  final PersistenceRepository persistenceRepository;

  FetchTodosUseCase(
      {required this.persistenceRepository, required this.todoRepository});

  Future<Either<Failure, List<todo_entity.Todo>>> execute() async {
    // Try to get todos from local persistence first
    final localTodoModels = await persistenceRepository.getAllTodoModels();

    if (localTodoModels.isNotEmpty) {
      final localEntities =
          localTodoModels.map((model) => model.toEntity()).toList();
      return Right(localEntities);
    }

    // Fallback to remote repository when no local todos
    final remoteTodosResult = await todoRepository.getTodos();
    return await remoteTodosResult.fold(
      (l) async => Left(l),
      (r) async {
        final todoModelList =
            r.map((todo) => TodoModel.fromEntity(todo)).toList();

        final todoIds =
            await persistenceRepository.saveTodoModelList(todoModelList);

        if (todoIds.isEmpty) {
          return Left(ServerFailure('Failed to save todos locally'));
        }

        final allTodoModels = await persistenceRepository.getAllTodoModels();

        if (allTodoModels.isNotEmpty) {
          final allTodoModelsEntities =
              allTodoModels.map((model) => model.toEntity()).toList();
          return Future.value(Right(allTodoModelsEntities));
        } else {
          return Left(ServerFailure('Failed to save todos locally'));
        }
      },
    );
  }
}
