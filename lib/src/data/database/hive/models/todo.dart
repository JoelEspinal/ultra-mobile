import 'package:hive/hive.dart';

import '../../../../domain/entities/todo.dart' as todo_entity;

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String todo;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final int userId;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final DateTime? dueDate;
  @HiveField(6)
  final int? priority;
  @HiveField(7)
  final String? category;
  @HiveField(8)
  final String? imagePath;
  @HiveField(9)
  final DateTime? reminderTime;
  @HiveField(10)
  final bool? isFavorite;
  @HiveField(11)
  final String? createdAt;
  @HiveField(12)
  final String? updatedAt;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    this.description,
    this.dueDate,
    this.priority,
    this.category,
    this.imagePath,
    this.reminderTime,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
  });

  todo_entity.Todo toEntity() {
    return todo_entity.Todo(
      id: id,
      todo: todo,
      completed: completed,
      userId: userId,
      description: description,
      dueDate: dueDate,
      priority: priority,
      category: category,
      imagePath: imagePath,
      reminderTime: reminderTime,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory Todo.fromTodoEntity(todo_entity.Todo todo) {
    return Todo(
        id: todo.id,
        todo: todo.todo,
        completed: todo.completed,
        userId: todo.userId,
        description: todo.description,
        dueDate: todo.dueDate,
        priority: todo.priority,
        category: todo.category,
        imagePath: todo.imagePath,
        reminderTime: todo.reminderTime,
        isFavorite: todo.isFavorite,
        createdAt: todo.createdAt,
        updatedAt: todo.updatedAt);
  }

  Todo copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
    String? description,
    DateTime? dueDate,
    int? priority,
    String? category,
    String? imagePath,
    DateTime? reminderTime,
    bool? isFavorite,
    String? createdAt,
    String? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      reminderTime: reminderTime ?? this.reminderTime,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static List<todo_entity.Todo> toEntityList(List<Todo> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static List<Todo> toTodoModelList(List<todo_entity.Todo> entities) {
    return entities.map((entry) => Todo.fromTodoEntity(entry)).toList();
  }
}
