import 'dart:async';

import '../entities/todo.dart';

abstract class RemoteTodoRepository {
  Future<Todo?> delete(int id);
  Future<List<Todo>> getTodoRemoteList();
  Future<Todo> getTodo(int id);
  Future<Todo?> updateTodo(Todo updateTodo);
}
