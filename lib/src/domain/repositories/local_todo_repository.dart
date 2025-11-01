import '../../data/database/hive/models/todo_model.dart';

abstract class LocalPersistenceRepository {
  Future<void> saveAll(List<Todo> todoModelList);
  Future<List<int>> addTodoModelList(List<Todo> todoModelList);
  Future<List<Todo>> getAllTodoModels();

  bool isBoxEmpty();
  Future<void> saveTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
}
