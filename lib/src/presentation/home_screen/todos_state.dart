import '../../domain/entities/todo.dart';

enum TodoStatus { initial, loading, success, failure }

class TodosState {
  final TodoStatus status;
  final List<Todo> todos;
  final String errorMessage;

  const TodosState({
    this.status = TodoStatus.initial,
    this.todos = const [],
    this.errorMessage = '',
  });

  TodosState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    String? errorMessage,
  }) {
    return TodosState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
