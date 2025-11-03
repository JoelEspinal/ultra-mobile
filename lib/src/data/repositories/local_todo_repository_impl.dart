import 'dart:async';

import '../../domain/repositories/local_todo_repository.dart';
import '../database/hive/models/todo.dart';
import './../database/hive/data_source/todo_local_data_source.dart';

class PersistenceRepositoryImpl implements LocalPersistenceRepository {
  final TodoLocalDataSource localDataSource;

  PersistenceRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveAll(List<Todo> todoModelList) async {
    await localDataSource.addAll(todoModelList);
  }

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
  Future<void> saveTodo(Todo todo) async {
    await localDataSource.addTodo(todo);
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
}
