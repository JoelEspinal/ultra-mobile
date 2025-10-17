import '../../domain/repositories/persistence_repository.dart';
import './../database/hive/data_source/todo_local_data_source.dart';

import '../../domain/entities/todo.dart' as todo_entity;

class PersistenceRepositoryImpl implements PersistenceRepository {
  final TodoLocalDataSource localDataSource;

  PersistenceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<todo_entity.Todo>> getTodos() async {
    return await localDataSource.getTodos();
  }

  @override
  Future<void> deleteTodo(int id) async {
    await localDataSource.deleteTodo(id);
  }

  @override
  Future<void> updateTodo(todo_entity.Todo todo) async {
    await localDataSource.updateTodo(todo);
  }

  @override
  todo_entity.Todo? getTodo(int id) {
    return localDataSource.getTodo(id);
  }

  @override
  Future<void> saveTodo(todo_entity.Todo todo) async {
    await localDataSource.addTodo(todo);
  }
}
