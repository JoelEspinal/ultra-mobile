import 'package:hive/hive.dart';
import '../../../../domain/entities/todo.dart'; // Import the Domain Entity

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {

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
  TodoModel({
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
