import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultra_mobile/src/domain/entities/todo.dart';
import 'package:ultra_mobile/src/domain/failures/failure.dart';
import 'package:ultra_mobile/src/domain/repositories/persistence_repository.dart';
import 'package:ultra_mobile/src/domain/repositories/todo_repository.dart';
import 'package:ultra_mobile/src/domain/use_cases/delete_todo_use_case.dart';
import 'package:ultra_mobile/src/domain/use_cases/fetch_todos_use_case.dart';
import 'package:ultra_mobile/src/presentation/todos_screen/todos_cubit.dart';
import 'package:ultra_mobile/src/presentation/todos_screen/todos_state.dart';

/// In-memory stand-in for the remote API repository.
class FakeTodoRepository implements TodoRepository {
  FakeTodoRepository({this.todos = const [], this.failure});

  final List<Todo> todos;
  final Failure? failure;

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async =>
      failure != null ? Left(failure!) : Right(todos);

  @override
  Future<Either<Failure, Todo>> getTodo(int id) async =>
      Right(todos.firstWhere((t) => t.id == id));

  @override
  Future<Either<Failure, Todo?>> delete(int id) async =>
      failure != null ? Left(failure!) : Right(todos.firstWhere((t) => t.id == id));

  @override
  Future<Either<Failure, Todo?>> updateTodo(Todo toUpdteTodo) async =>
      Right(toUpdteTodo);
}

/// In-memory stand-in for the Hive persistence layer.
class FakePersistenceRepository implements PersistenceRepository {
  final Map<int, Todo> store = {};

  @override
  Future<Todo?> getTodo(int id) async => store[id];

  @override
  Future<List<Todo>> getTodos() async => store.values.toList();

  @override
  Future<void> saveTodo(Todo todo) async => store[todo.id] = todo;

  @override
  Future<void> updateTodo(Todo todo) async => store[todo.id] = todo;

  @override
  Future<void> deleteTodo(int id) async => store.remove(id);
}

Todo todo(int id, String text, {bool completed = false}) =>
    Todo(id: id, todo: text, completed: completed, userId: 1);

TodosCubit buildCubit(FakeTodoRepository remote) => TodosCubit(
      FetchTodosUseCase(
        todoRepository: remote,
        persistenceRepository: FakePersistenceRepository(),
      ),
      DeleteTodoUseCase(todoRepository: remote),
    );

void main() {
  final sample = [
    todo(1, 'Buy milk'),
    todo(2, 'Write the README'),
    todo(3, 'Walk the dog', completed: true),
  ];

  group('TodosCubit', () {
    test('starts in the initial state with no todos', () {
      final cubit = buildCubit(FakeTodoRepository());

      expect(cubit.state.status, TodoStatus.initial);
      expect(cubit.state.todos, isEmpty);
    });

    test('loadTodos emits success with the fetched todos', () async {
      final cubit = buildCubit(FakeTodoRepository(todos: sample));

      await cubit.loadTodos();

      expect(cubit.state.status, TodoStatus.success);
      expect(cubit.state.todos.map((t) => t.id), [1, 2, 3]);
      expect(cubit.state.errorMessage, isEmpty);
    });

    test('loadTodos filters by text, ignoring case', () async {
      final cubit = buildCubit(FakeTodoRepository(todos: sample));

      await cubit.loadTodos('readme');

      expect(cubit.state.todos.map((t) => t.id), [2]);
    });

    test('loadTodos maps a network failure to a friendly message', () async {
      final cubit =
          buildCubit(FakeTodoRepository(failure: const NetworkFailure()));

      await cubit.loadTodos();

      expect(cubit.state.status, TodoStatus.failure);
      expect(cubit.state.errorMessage, 'Check your internet connection!');
    });

    test('toggleFavorite flips only the selected todo', () async {
      final cubit = buildCubit(FakeTodoRepository(todos: sample));
      await cubit.loadTodos();

      cubit.toggleFavorite(2);

      expect(cubit.state.todos.firstWhere((t) => t.id == 2).isFavorite, isTrue);
      expect(cubit.state.todos.firstWhere((t) => t.id == 1).isFavorite, isNull);
    });

    test('toggleTodoStatus flips completed for the selected todo', () async {
      final cubit = buildCubit(FakeTodoRepository(todos: sample));
      await cubit.loadTodos();

      cubit.toggleTodoStatus(3);

      expect(cubit.state.todos.firstWhere((t) => t.id == 3).completed, isFalse);
    });

    test('deleteTodo removes the todo from the list', () async {
      final cubit = buildCubit(FakeTodoRepository(todos: sample));
      await cubit.loadTodos();

      cubit.deleteTodo(1);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.status, TodoStatus.success);
      expect(cubit.state.todos.map((t) => t.id), [2, 3]);
    });
  });
}
