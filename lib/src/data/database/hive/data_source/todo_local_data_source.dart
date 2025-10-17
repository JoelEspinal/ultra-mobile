import 'package:hive/hive.dart';
import '../../../../domain/entities/todo.dart';
import '../models/todo_model.dart';
// 1. IMPORT THE GENERATED ADAPTER FILE

// import '../models/todo_model.g.dart';

// Define the contract (interface) for the local data source
abstract class TodoLocalDataSource {
  Future<void> addTodo(Todo todo);
  Todo? getTodo(int todoId);
  Future<List<Todo>> getTodos();
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
}

// Concrete Hive implementation
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  static const String _todoBoxName = 'todos';

  // Initialize and register adapters (must be called once at startup)
  static Future<void> initHive() async {
    // Hive initialization usually happens in main()
    // await Hive.initFlutter();
    // This registration now works because todo_model.g.dart is imported.
    Hive.registerAdapter(TodoModelAdapter());
    await Hive.openBox<TodoModel>(_todoBoxName);
  }

  Box<TodoModel> get _todoBox => Hive.box<TodoModel>(_todoBoxName);

  @override
  Todo? getTodo(int todoId) {
    TodoModel? todoModel = _todoBox.get(todoId);
    if (todoModel == null) return null;

    return todoModel.toEntity();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    // Hive uses the model's type ID (0 in this case) and saves it
    await _todoBox.put(todo.id, todoModel);
  }

  @override
  Future<List<Todo>> getTodos() async {
    // Get all TodoModels, map them back to domain Entities
    return _todoBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    // Use put with the key (ID) to overwrite the existing record
    await _todoBox.put(todo.id, todoModel);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _todoBox.delete(id);
  }
}
