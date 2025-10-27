import 'dart:async';

import '../network/todos_api/models/todo.dart' as todo_model;
import '../../domain/entities/todo.dart';
import '../network/error_handler.dart';
import '../network/todos_api/services/todo_service.dart';
import '../../domain/repositories/remote_todo_repository.dart';

class RemoteTodoRepositoryImpl implements RemoteTodoRepository {
  final TodoService todoRemoteService;

  RemoteTodoRepositoryImpl({required this.todoRemoteService});

  @override
  Future<Todo?> delete(int id) async {
    try {
      final t = await todoRemoteService.deleteTodo(id);
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
  Future<List<Todo>> getAll() async {
    try {
      final todosResponse = await todoRemoteService.fetchTodos();

      if (todosResponse.todos.isEmpty) {
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

      return todoEntities;
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Todo> getTodo(int id) async {
    try {
      final remoteTodo = await todoRemoteService.fetchTodo(id);
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
      // final todo = (t) => Todo(
      //       id: t.id,
      //       todo: t.todo,
      //       completed: t.completed,
      //       userId: t.userId,
      //     );

      final todoModel = todo_model.Todo(
        id: updateTodo.id,
        todo: updateTodo.todo,
        completed: updateTodo.completed,
        userId: updateTodo.userId,
      );

      final updatedTodo = await todoRemoteService.updateTodo(todoModel);

      if (updatedTodo == null) return null;

      final todoEntity = updatedTodo.map(
        (t) => Todo(
          id: t.id,
          todo: t.todo,
          completed: t.completed,
          userId: t.userId,
        ),
      );

      return todoEntity;
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
