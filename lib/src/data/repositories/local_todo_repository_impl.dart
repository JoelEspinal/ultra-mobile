import 'dart:async';

import '../../domain/repositories/local_todo_repository.dart';
import '../database/hive/models/todo.dart';
import './../database/hive/data_source/todo_local_data_source.dart';

class LocalPersistenceRepositoryImpl implements LocalPersistenceRepository {
  final TodoLocalDataSource localDataSource;

  LocalPersistenceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<int>> addTodoModelList(List<Todo> todoModelList) async {
    final ids = await localDataSource.addAll(todoModelList);
    return Future.value(ids);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await localDataSource.deleteTodo(id);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await localDataSource.updateTodo(todo);
  }

  @override
  Future<bool> isBoxEmpty() async {
    return await localDataSource.isBoxEmpty();
  }

  @override
  Future<List<Todo>> getAllTodoModels() async {
    final todoModelList = await localDataSource.getAllTodos();
    return Future.value(todoModelList);
  }

  @override
  Future<List<int>> addAll(List<Todo> todos) {
    return localDataSource.addAll(todos);
  }

  @override
  Future<void> addTodo(Todo todo) {
    return localDataSource.addTodo(todo);
  }

  @override
  Future<List<Todo>> getAllTodos() {
    return localDataSource.getAllTodos();
  }

  @override
  Future<Todo?> getTodo(int todoId) {
    return localDataSource.getTodo(todoId);
  }
}
