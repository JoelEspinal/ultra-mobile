import '../../data/database/hive/models/todo.dart';

abstract class LocalPersistenceRepository {
  Future<void> saveAll(List<Todo> todoModelList);
  Future<List<int>> addTodoModelList(List<Todo> todoModelList);
  Future<List<Todo>> getAllTodoModels();

  Future<bool> isBoxEmpty();
  Future<void> saveTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
}
