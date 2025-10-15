import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo.dart';

part 'todo_response.freezed.dart';
part 'todo_response.g.dart';

@freezed
abstract class TodosResponse with _$TodosResponse {
  const factory TodosResponse({
    // The list of Todo items
    required List<Todo> todos,

    // The other metadata fields
    required int total,
    required int skip,
    required int limit,
  }) = _TodosResponse;

  factory TodosResponse.fromJson(Map<String, dynamic> json) =>
      _$TodosResponseFromJson(json);
}
