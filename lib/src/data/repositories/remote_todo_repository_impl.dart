import 'dart:async';

import '../network/todos_api/data_source/todo_response.dart';

import '../network/todos_api/data_source/todo.dart' as todo_model;
import '../../domain/entities/todo.dart';
import '../../common/error_handler.dart';
import '../network/todos_api/services/remote_todo_service.dart';
import '../../domain/repositories/remote_todo_repository.dart';

class RemoteTodoRepositoryImpl implements RemoteTodoRepository {
  final RemoteTodoService remoteTodoService;

  RemoteTodoRepositoryImpl({required this.remoteTodoService});

  @override
  Future<Todo?> delete(int id) async {
    try {
      final t = await remoteTodoService.deleteTodo(id);
      if (t == null) {
        return null;
      }

      final todoEntity = Todo(
        id: t.id,
        todo: t.todo,
        completed: t.completed,
        userId: t.userId,
      );

      return todoEntity;
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<Todo>> getTodoRemoteList() async {
    try {
      TodosResponse? todosResponse = await remoteTodoService.fetchTodos();

      if (todosResponse == null) {
        return Future.value([]);
      }

      final todoEntities = todosResponse.todos
          .map(
            (remoteTodo) => Todo(
              id: remoteTodo.id,
              todo: remoteTodo.todo,
              completed: remoteTodo.completed,
              userId: remoteTodo.userId,
            ),
          )
          .toList();

      return Future.value(todoEntities);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Todo> getTodo(int id) async {
    try {
      final remoteTodo = await remoteTodoService.fetchTodo(id);
      final todo = Todo(
        id: remoteTodo.id,
        todo: remoteTodo.todo,
        completed: remoteTodo.completed,
        userId: remoteTodo.userId,
      );

      return todo;
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Todo?> updateTodo(Todo updateTodo) async {
    try {
      final todoModel = todo_model.Todo.fromJson(updateTodo.toJson());
      final updatedTodo = await remoteTodoService.updateTodo(todoModel);

      if (updatedTodo == null) return null;

      final todoEntity = Todo.fromJson(updatedTodo.toJson());

      return todoEntity;
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
