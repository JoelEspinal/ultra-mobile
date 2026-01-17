import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';

import 'todo.dart';

class TodosResponse {
  List<Todo> todos;
  int total;
  int skip;
  int limit;

  TodosResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  TodosResponse copyWith({
    List<Todo>? todos,
    int? total,
    int? skip,
    int? limit,
  }) {
    return TodosResponse(
      todos: todos ?? this.todos,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'todos': todos.map((x) => x.toMap()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }

  factory TodosResponse.fromMap(Map<String, dynamic> map) {
    return TodosResponse(
      todos: List<Todo>.from(map['todos']?.map((x) => Todo.fromMap(x))),
      total: map['total']?.toInt() ?? 0,
      skip: map['skip']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodosResponse.fromJson(String source) =>
      TodosResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodosResponse(todos: $todos, total: $total, skip: $skip, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodosResponse &&
        listEquals(other.todos, todos) &&
        other.total == total &&
        other.skip == skip &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return todos.hashCode ^ total.hashCode ^ skip.hashCode ^ limit.hashCode;
  }
}
