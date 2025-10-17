import 'package:hive/hive.dart';
import '../../../../domain/entities/todo.dart'; // Import the Domain Entity

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  // 1. Redefine all final fields directly within the model.

  @HiveField(0)
  int id;

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

  // 2. Define a standard constructor for the model.
  // NOTE: 'required' is removed, so default values must be provided for non-nullable final fields.
  TodoModel({
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

  // 3. Factory method to convert Domain Entity to Data Model
  factory TodoModel.fromEntity(Todo entity) {
    return TodoModel(
      id: entity.id,
      todo: entity.todo,
      completed: entity.completed,
      userId: entity.userId,
      description: entity.description,
      dueDate: entity.dueDate,
      priority: entity.priority,
      category: entity.category,
      imagePath: entity.imagePath,
      reminderTime: entity.reminderTime,
      isFavorite: entity.isFavorite,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // 4. Method to convert Data Model back to Domain Entity
  Todo toEntity() {
    return Todo(
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
}
