import 'dart:async';

import '../../common/failures/failure.dart';
import '../../domain/repositories/local_todo_repository.dart';
import '../database/hive/models/todo.dart';
import './../database/hive/data_source/todo_local_data_source.dart';

class LocalPersistenceRepositoryImpl implements LocalPersistenceRepository {
  final TodoLocalDataSource localDataSource;

  LocalPersistenceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<int>> addTodoModelList(List<Todo> todoModelList) async {
    try {
      final ids = await localDataSource.addAll(todoModelList);
      return Future.value(ids);
    } catch (e) {
      throw UnableToSaveLocalListFailure(e.toString());
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await localDataSource.deleteTodo(id);
    } catch (e) {
      throw UnableDeleteFailure(e.toString());
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    try {
      final syncedTodo = todo.copyWith(needsSync: true);
      await localDataSource.updateTodo(syncedTodo);
    } catch (e) {
      throw UnableUpdateFailure(e.toString());
    }
  }

  @override
  Future<bool> isBoxEmpty() async {
    try {
      return await localDataSource.isBoxEmpty();
    } catch (e) {
      throw UnableOpenBox(e.toString());
    }
  }

  @override
  Future<List<Todo>> getAllTodoModels() async {
    try {
      final todoModelList = await localDataSource.getAllTodos();
      return Future.value(todoModelList);
    } catch (e) {
      throw UnableToObtainAllTodos(e.toString());
    }
  }

  @override
  Future<List<int>> addAll(List<Todo> todos) {
    try {
      return localDataSource.addAll(todos);
    } catch (e) {
      throw UnableToAddTodos(e.toString());
    }
  }

  @override
  Future<void> addTodo(Todo todo) {
    try {
      final syncedTodo = todo.copyWith(needsSync: true);
      return localDataSource.addTodo(syncedTodo);
    } catch (e) {
      throw UnableToAddTodo(e.toString());
    }
  }

  @override
  Future<List<Todo>> getAllTodos() {
    try {
      return localDataSource.getAllTodos();
    } catch (e) {
      throw UnableToAddLocalTodos(e.toString());
    }
  }

  @override
  Future<Todo?> getTodo(int id) {
    try {
      return localDataSource.getTodo(id);
    } catch (e) {
      throw UnableToFindLocalTodo(e.toString());
    }
  }

  @override
  Future<Todo> toggleFavorite(Todo todo) async {
    try {
      if (todo.isFavorite == null) {
        final result = todo.copyWith(isFavorite: false, needsSync: true);
        return Future.value(result);
      } else {
        bool result = todo.isFavorite! ? false : true;
        final resultTodo = todo.copyWith(isFavorite: result, needsSync: true);
        return Future.value(resultTodo);
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<Todo> toggleCompleted(Todo todo) {
    final updatedTodo = todo.copyWith(completed: !todo.completed, needsSync: true);
    return Future.value(updatedTodo);
  }
}
