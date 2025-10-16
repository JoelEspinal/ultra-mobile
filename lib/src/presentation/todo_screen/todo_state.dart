import '../../domain/entities/todo.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState {
  final TodoStatus status;
  final Todo todo;
  final String errorMessage;

  TodoState({
    required this.status,
    required this.todo,
    required this.errorMessage,
  });

  TodoState copyWith({TodoStatus? status, Todo? todo, String? errorMessage}) {
    return TodoState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
