import '../../domain/entities/todo.dart';
import '../../data/native/todo_api.g.dart';

enum TodoDetailStatus { initial, loading, success, failure, updating }

enum Priority { high, medium, low }

class TodoDetail {
  final int id;
  final String task;
  final bool completed;
  final String description;
  final DateTime? dueDate;
  final Priority priority;
  final String category;
  final bool isFavorite;
  final String? imagePath;
  final String? imageUrl; // Added imageUrl
  final DateTime? reminderTime;
  final int userId;

  const TodoDetail({
    required this.id,
    required this.task,
    required this.completed,
    this.description = '',
    this.dueDate,
    this.priority = Priority.medium,
    this.category = '',
    this.isFavorite = false,
    this.imagePath,
    this.imageUrl,
    this.reminderTime,
    required this.userId,
  });

  TodoDetail copyWith({
    int? id,
    String? task,
    bool? completed,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    String? category,
    bool? isFavorite,
    String? imagePath,
    String? imageUrl,
    DateTime? reminderTime,
    int? userId,
  }) {
    return TodoDetail(
      id: id ?? this.id,
      task: task ?? this.task,
      completed: completed ?? this.completed,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      imagePath: imagePath ?? this.imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      reminderTime: reminderTime ?? this.reminderTime,
      userId: userId ?? this.userId,
    );
  }

  // Factory to create from basic Todo entity
  factory TodoDetail.fromTodo(Todo todo) {
    // Ensure we use the Priority enum directly, or default to medium if null
    final Priority priority =
        (todo.priority is Priority) ? todo.priority as Priority : Priority.medium;

    return TodoDetail(
      id: todo.id,
      task: todo.todo ?? '',
      completed: todo.completed,
      userId: todo.userId,
      category: todo.category ?? "",
      description: todo.description ?? "",
      imagePath: todo.imagePath ?? "",
      dueDate: todo.dueDate,
      isFavorite: todo.isFavorite ?? false,
      priority: priority,
      reminderTime: todo.reminderTime,
    );
  }

  // Method to merge data from native bridge
  TodoDetail mergeNative(TodoDetailNative native) {
    return copyWith(
      description: native.description ?? description,
      category: native.category ?? category,
      priority: native.priority != null ? Priority.values[native.priority!] : priority,
      dueDate: native.dueDate != null ? DateTime.fromMillisecondsSinceEpoch(native.dueDate!) : dueDate,
      imageUrl: native.imageUrl ?? imageUrl,
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
