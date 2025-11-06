import '../../data/database/hive/models/todo.dart';

abstract class LocalPersistenceRepository {
  Future<bool> isBoxEmpty();
  Future<void> addTodo(Todo todo);
  Future<Todo?> getTodo(int id);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
  Future<Todo> toggleFavorite(Todo todo);

  Future<List<Todo>> getAllTodos();
  Future<List<int>> addAll(List<Todo> todos);
  Future<List<int>> addTodoModelList(List<Todo> todoModelList);
  Future<List<Todo>> getAllTodoModels();
}
