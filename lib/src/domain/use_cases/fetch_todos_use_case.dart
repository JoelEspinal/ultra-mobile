import 'package:dartz/dartz.dart';
import 'package:ultra_mobile/src/domain/repositories/persistence_repository.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class FetchTodosUseCase {
  final TodoRepository todoRepository;
  final PersistenceRepository persistenceRepository;

  FetchTodosUseCase(
      {required this.persistenceRepository, required this.todoRepository});

  /// Fetches the to-dos from the API and caches the new ones locally.
  ///
  /// - When new to-dos were cached, returns the local list (the source of truth).
  /// - When the API fails, falls back to the cached to-dos so the app works offline,
  ///   and only returns the failure if there is nothing cached yet.
  Future<Either<Failure, List<todo_entity.Todo>>> execute() async {
    final remote = await todoRepository.getTodos();

    return remote.fold(
      (failure) async {
        final cached = await persistenceRepository.getTodos();
        return cached.isNotEmpty ? Right(cached) : Left(failure);
      },
      (todos) async {
        var savedNew = false;
        for (final todo in todos) {
          final stored = await persistenceRepository.getTodo(todo.id);
          if (stored == null) {
            await persistenceRepository.saveTodo(todo);
            savedNew = true;
          }
        }

        if (savedNew) {
          return Right(await persistenceRepository.getTodos());
        }
        return Right(todos);
      },
    );
  }
}
