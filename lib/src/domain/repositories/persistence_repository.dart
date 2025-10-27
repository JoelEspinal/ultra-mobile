import '../../data/database/hive/models/todo_model.dart';

abstract class PersistenceRepository {
  Future<List<TodoModel>> getAllTodoModels();
  Future<List<int>> saveTodoModelList(List<TodoModel> todoModelList);

  // Future<todo_entity.Todo?> getTodo(int id);
  Future<void> saveTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
}
