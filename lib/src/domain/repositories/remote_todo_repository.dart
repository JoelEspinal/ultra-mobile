import 'dart:async';

import '../entities/todo.dart';

abstract class RemoteTodoRepository {
  Future<List<Todo>> getAll();
  Future<Todo> getTodo(int key);
  Future<Todo?> delete(int key);
  Future<Todo?> updateTodo(Todo toUpdteTodo);
}
