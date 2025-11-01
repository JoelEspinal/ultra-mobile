import 'dart:async';

import '../../domain/repositories/local_todo_repository.dart';
import '../database/hive/models/todo_model.dart';
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
  bool isBoxEmpty() {
    return localDataSource.isBoxEmpty();
  }

  @override
  Future<List<Todo>> getAllTodoModels() async {
    final todoModelList = await localDataSource.getAllTodos();
    return Future.value(todoModelList);
  }

  // @override
  // Future<todo_entity.Todo?> getTodo(int id) async {
  //   var value = localDataSource.getTodo(id);
  //   return value;
  // }

  // @override
  // Future<void> saveTodo(Todo todo) async {
  //   await localDataSource.addTodo(todo);
  // }
}
