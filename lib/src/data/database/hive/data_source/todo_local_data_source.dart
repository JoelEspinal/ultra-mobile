import 'package:hive/hive.dart';

import '../../../../common/failures/failure.dart';
import '../models/todo.dart';

class TodoLocalDataSource {
  final String _todoBoxName = 'todos';

  Box<Todo> get todoBox {
    return Hive.box<Todo>(_todoBoxName);
  }

  Future<List<int>> addAll(List<Todo> todos) async {
    final box = todoBox;
    final keys = await box.addAll(todos);
    return Future.value(keys.toList());
  }

  Future<void> addTodo(Todo todo) async {
    final box = todoBox;
    final key = await box.add(todo);
    final localTodo = box.get(key);

    if (localTodo != null) {
      return await box.put(key, localTodo);
    }
  }

  Future<Todo?> getTodo(int todoId) async {
    final iterableTodo = todoBox.values.where((model) => model.id == todoId);
    var localTodo = iterableTodo.firstOrNull;
    return Future.value(localTodo);
  }

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

  Future<void> updateTodo(Todo todo) async {
    final box = todoBox;
    final key = getKeyFromValue(box, todo);
    return box.put(key, todo);
  }

  Future<void> deleteTodo(int id) async {
    try {
      final box = todoBox;
      Todo todoValue = box.values.firstWhere((element) => element.id == id);
      final key = getKeyFromValue(box, todoValue);
      if (key == null) throw UnablToFindKeyFailire("$id");

      return await box.delete(key);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isBoxEmpty() async {
    final box = todoBox;
    final value = box.values.isEmpty;
    return Future.value(value);
  }

  int? getKeyFromValue(Box box, Todo targetValue) {
    for (var entry in box.toMap().entries) {
      if (entry.value.id == targetValue.id) {
        return entry.key;
      }
    }
    return null; // Value not found
  }
}
