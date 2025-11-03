import 'package:hive/hive.dart';

import '../../../../domain/entities/todo.dart'
    as todo_entity; // Import the Domain Entity

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  int localId;

  @HiveField(1)
  int id;

  @HiveField(2)
  String todo;

  @HiveField(3)
  bool completed;

  @HiveField(4)
  int userId;

  @HiveField(5)
  String? description;

  @HiveField(6)
  DateTime? dueDate;

  @HiveField(7)
  int? priority;

  @HiveField(8)
  String? category;

  @HiveField(9)
  String? imagePath;

  @HiveField(10)
  DateTime? reminderTime;

  @HiveField(11)
  bool? isFavorite;

  @HiveField(12)
  String? createdAt;

  @HiveField(13)
  String? updatedAt;

  // 2. Define a standard constructor for the model.
  // NOTE: 'required' is removed, so default values must be provided for non-nullable final fields.
  Todo({
    this.localId = 0,
    this.id = 0,
    this.todo = '',
    this.completed = false,
    this.userId = 0,
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

  // 4. Method to convert Data Model back to Domain Entity
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

  static List<todo_entity.Todo> toEntityList(List<Todo> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static List<Todo> toTodoModelList(List<todo_entity.Todo> entities) {
    return entities.map((entry) => Todo.fromTodoEntity(entry)).toList();
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
}
