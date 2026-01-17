import 'dart:convert';

import 'package:flutter/widgets.dart';

class Todo {
  int id;
  String todo;
  bool completed;
  int userId;
  // optional fields
  String? description;
  DateTime? dueDate;
  int? priority;
  String? category;
  String? imageUrl;
  DateTime? reminderTime;
  bool? isFavorite;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    this.description,
    this.dueDate,
    this.priority,
    this.category,
    this.imageUrl,
    this.reminderTime,
    this.isFavorite,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  Todo copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
    ValueGetter<String?>? description,
    ValueGetter<DateTime?>? dueDate,
    ValueGetter<int?>? priority,
    ValueGetter<String?>? category,
    ValueGetter<String?>? imageUrl,
    ValueGetter<DateTime?>? reminderTime,
    ValueGetter<bool?>? isFavorite,
    ValueGetter<String?>? imagePath,
    ValueGetter<String?>? createdAt,
    ValueGetter<String?>? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      description: description != null ? description() : this.description,
      dueDate: dueDate != null ? dueDate() : this.dueDate,
      priority: priority != null ? priority() : this.priority,
      category: category != null ? category() : this.category,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
      reminderTime: reminderTime != null ? reminderTime() : this.reminderTime,
      isFavorite: isFavorite != null ? isFavorite() : this.isFavorite,
      imagePath: imagePath != null ? imagePath() : this.imagePath,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
      'description': description,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'priority': priority,
      'category': category,
      'imageUrl': imageUrl,
      'reminderTime': reminderTime?.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id']?.toInt() ?? 0,
      todo: map['todo'] ?? '',
      completed: map['completed'] ?? false,
      userId: map['userId']?.toInt() ?? 0,
      description: map['description'],
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'])
          : null,
      priority: map['priority']?.toInt(),
      category: map['category'],
      imageUrl: map['imageUrl'],
      reminderTime: map['reminderTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminderTime'])
          : null,
      isFavorite: map['isFavorite'],
      imagePath: map['imagePath'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId, description: $description, dueDate: $dueDate, priority: $priority, category: $category, imageUrl: $imageUrl, reminderTime: $reminderTime, isFavorite: $isFavorite, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.todo == todo &&
        other.completed == completed &&
        other.userId == userId &&
        other.description == description &&
        other.dueDate == dueDate &&
        other.priority == priority &&
        other.category == category &&
        other.imageUrl == imageUrl &&
        other.reminderTime == reminderTime &&
        other.isFavorite == isFavorite &&
        other.imagePath == imagePath &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        todo.hashCode ^
        completed.hashCode ^
        userId.hashCode ^
        description.hashCode ^
        dueDate.hashCode ^
        priority.hashCode ^
        category.hashCode ^
        imageUrl.hashCode ^
        reminderTime.hashCode ^
        isFavorite.hashCode ^
        imagePath.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
