import 'package:flutter_test/flutter_test.dart';
import 'package:ultra_mobile/src/domain/entities/todo.dart';
import 'package:ultra_mobile/src/domain/failures/failure.dart';
import 'package:ultra_mobile/src/domain/use_cases/fetch_todos_use_case.dart';

import '../presentation/todos_cubit_test.dart'
    show FakePersistenceRepository, FakeTodoRepository, todo;

void main() {
  final remoteTodos = [todo(1, 'Buy milk'), todo(2, 'Write the README')];

  group('FetchTodosUseCase', () {
    test('caches new todos and waits until they are saved', () async {
      final local = FakePersistenceRepository();
      final useCase = FetchTodosUseCase(
        todoRepository: FakeTodoRepository(todos: remoteTodos),
        persistenceRepository: local,
      );

      final result = await useCase.execute();

      expect(local.store.keys, [1, 2]);
      expect(result.getOrElse(() => []).map((t) => t.id), [1, 2]);
    });

    test('returns the local version when new todos were cached', () async {
      final local = FakePersistenceRepository()
        ..store[2] = todo(2, 'Write the README', completed: true);
      final useCase = FetchTodosUseCase(
        todoRepository: FakeTodoRepository(todos: remoteTodos),
        persistenceRepository: local,
      );

      final todos = (await useCase.execute()).getOrElse(() => <Todo>[]);

      expect(todos.firstWhere((t) => t.id == 2).completed, isTrue);
      expect(todos.map((t) => t.id), containsAll([1, 2]));
    });

    test('falls back to cached todos when the API fails', () async {
      final local = FakePersistenceRepository()..store[1] = todo(1, 'Buy milk');
      final useCase = FetchTodosUseCase(
        todoRepository: FakeTodoRepository(failure: const NetworkFailure()),
        persistenceRepository: local,
      );

      final result = await useCase.execute();

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => []).map((t) => t.id), [1]);
    });

    test('returns the failure when the API fails and nothing is cached',
        () async {
      final useCase = FetchTodosUseCase(
        todoRepository: FakeTodoRepository(failure: const NetworkFailure()),
        persistenceRepository: FakePersistenceRepository(),
      );

      final result = await useCase.execute();

      expect(result.isLeft(), isTrue);
      result.fold((f) => expect(f, isA<NetworkFailure>()), (_) => fail('Expected a failure'));
    });
  });
}
