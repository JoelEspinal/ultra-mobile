import '../../domain/entities/todo.dart' as todo_entity;

abstract class PersistenceRepository {
  Future<todo_entity.Todo?> getTodo(int id);
  Future<List<todo_entity.Todo>> getTodos();
  Future<void> saveTodo(todo_entity.Todo todo);
  Future<void> updateTodo(todo_entity.Todo todo);
  Future<void> deleteTodo(int id);
}
