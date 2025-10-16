import '../../domain/entities/todo.dart';

enum TodoDetailStatus { initial, loading, success, failure, updating }

enum Priority { high, medium, low }

class TodoDetail {
  final int id;
  final String todo;
  final bool completed;
  final String description;
  final DateTime? dueDate;
  final Priority priority;
  final String category;
  final bool isFavorite;
  final String? imagePath;
  final DateTime? reminderTime;
  final int userId;

  const TodoDetail({
    required this.id,
    required this.todo,
    required this.completed,
    this.description = '',
    this.dueDate,
    this.priority = Priority.medium,
    this.category = '',
    this.isFavorite = false,
    this.imagePath,
    this.reminderTime,
    required this.userId,
  });

  TodoDetail copyWith({
    int? id,
    String? todo,
    bool? completed,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    String? category,
    bool? isFavorite,
    String? imagePath,
    DateTime? reminderTime,
    int? userId,
  }) {
    return TodoDetail(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      imagePath: imagePath ?? this.imagePath,
      reminderTime: reminderTime ?? this.reminderTime,
      userId: userId ?? this.userId,
    );
  }

  // Factory to create from basic Todo entity
  factory TodoDetail.fromTodo(Todo todo) {
    return TodoDetail(
      id: todo.id,
      todo: todo.todo,
      completed: todo.completed,
      userId: todo.userId,
    );
  }
}

class TodoDetailState {
  final TodoDetailStatus status;
  final TodoDetail? todoDetail;
  final String errorMessage;

  const TodoDetailState({
    this.status = TodoDetailStatus.initial,
    this.todoDetail,
    this.errorMessage = '',
  });

  TodoDetailState copyWith({
    TodoDetailStatus? status,
    TodoDetail? todoDetail,
    String? errorMessage,
  }) {
    return TodoDetailState(
      status: status ?? this.status,
      todoDetail: todoDetail ?? this.todoDetail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
