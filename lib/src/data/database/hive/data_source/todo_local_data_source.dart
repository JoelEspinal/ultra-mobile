import 'package:hive/hive.dart';

import '../models/todo.dart';

// Define the contract (interface) for the local data source
abstract class TodoLocalDataSource {
  Future<void> addTodo(Todo todo);
  Future<Todo?> getTodo(int todoId);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
  Future<bool> isBoxEmpty();

  Future<List<int>> addAll(List<Todo> todos);
  Future<List<Todo>> getAllTodos();
}

// Concrete Hive implementation
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final String _todoBoxName = 'todos';

  // Future<Box<Todo>> todoBox async {
  //   final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  //   // Check if the box is already open to prevent errors/warnings
  //   if (!Hive.isBoxOpen(_todoBoxName)) {
  //     final openBox =
  //         await Hive.openBox<Todo>(_todoBoxName, path: appDocumentsDir.path);
  //     return Future.value(openBox);
  //   } else {
  //     return Future.value(Hive.box<Todo>(_todoBoxName));
  //   }
  // }

  Box<Todo> get todoBox {
    return Hive.box<Todo>(_todoBoxName);
  }

  @override
  Future<List<int>> addAll(List<Todo> todos) async {
    final box = todoBox;
    final keys = await box.addAll(todos);
    return Future.value(keys.toList());
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final box = todoBox;
    final key = await box.add(todo);
    final localTodo = box.get(key);

    if (localTodo != null) {
      return await box.put(key, localTodo);
    }
  }

  @override
  Future<Todo?> getTodo(int todoId) async {
    final iterableTodo = todoBox.values.where((model) => model.id == todoId);
    var localTodo = iterableTodo.firstOrNull;
    return Future.value(localTodo);
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    try {
      final box = todoBox;
      List<Todo> todoList = [];

      final modelKeys = box.keys.toList();
      for (var key in modelKeys) {
        final todo = box.get(key);
        if (todo != null) {
          todoList.add(todo);
        }
      }
      return Future.value(todoList);
    } catch (e) {
      print('Error: Box contains wrong data type for Todo: $e');
      return [];
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final box = todoBox;
    final localTodo = await getTodo(todo.id);

    if (localTodo != null) {
      final key = getKeyFromValue(box, localTodo);
      return box.put(key, todo);
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    final box = todoBox;

    await box.delete(id);
  }

  @override
  Future<bool> isBoxEmpty() async {
    final box = todoBox;
    final value = box.values.isEmpty;
    return Future.value(value);
  }

  String? getKeyFromValue(Box box, dynamic targetValue) {
    for (var entry in box.toMap().entries) {
      if (entry.value == targetValue) {
        return entry.key;
      }
    }
    return null; // Value not found
  }
}
