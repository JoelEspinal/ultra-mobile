import 'package:ultra_mobile/src/data/database/hive/models/todo_model.dart';

import '../../domain/repositories/persistence_repository.dart';
import './../database/hive/data_source/todo_local_data_source.dart';

class PersistenceRepositoryImpl implements PersistenceRepository {
  final TodoLocalDataSource localDataSource;

  PersistenceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TodoModel>> getAllTodoModels() async {
    final todoModelList = await localDataSource.getTodos();
    return Future.value(todoModelList);
  }

  Future<List<int>> saveTodoModelList(List<TodoModel> todoModelList) async {
    final todoIds = await localDataSource.addAll(todoModelList);
    return Future.value(todoIds);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await localDataSource.deleteTodo(id);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await localDataSource.updateTodo(todo);
  }

  // @override
  // Future<todo_entity.Todo?> getTodo(int id) async {
  //   var value = localDataSource.getTodo(id);
  //   return value;
  // }

  @override
  Future<void> saveTodo(TodoModel todo) async {
    await localDataSource.addTodo(todo);
  }

  // @override
  // Future<void> saveTodo(Todo todo) async {
  //   await localDataSource.addTodo(todo);
  // }
}
