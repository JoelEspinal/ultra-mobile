import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

// part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  factory Todo({
    required int id,
    required String todo,
    required bool completed,
    required int userId,
    // optional fields
    String? description,
    DateTime? dueDate,
    int? priority,
    String? category,
    String? imageUrl,
    String? reminderTime,
    bool? isFavorite,
    String? createdAt,
    String? updatedAt,
  }) = _Todo;
}
