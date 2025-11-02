import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/todo_model.dart';

// Define the contract (interface) for the local data source
abstract class TodoLocalDataSource {
  Future<void> addTodo(Todo todo);
  Future<List<int>> addAll(List<Todo> todos);
  // Todo? getTodo(int todoId);

  Future<List<Todo>> getAllTodos();
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
  bool isBoxEmpty();
}

// Concrete Hive implementation
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  static late Box<Todo> _box;
  static const String _todoBoxName = 'todos';

  static Future<void> init() async {
    // Check if the box is already open to prevent errors/warnings
    if (!Hive.isBoxOpen(_todoBoxName)) {
      _box = await Hive.openBox<Todo>(_todoBoxName);
    } else {
      _box = Hive.box<Todo>(_todoBoxName);
    }
  }

  Box<Todo> get todoBox {
    return _box;
  }

  @override
  Future<List<int>> addAll(List<Todo> todos) async {
    var keys = await todoBox.addAll(todos);
    var keyList = keys.toList();
    return keyList;
  }

  // Future<List<Todo>> getAllTodos() {
  //   final todoList = todoBox.values.toList();
  //   return Future.value(todoList);
  // }

  // @override
  // Todo? getTodo(int todoId) {
  //   // TodoModel? todoModel = _todoBox.get(todoId);
  //   final iterableTodo =
  //       _todoBox.values.where((element) => element.id == todoId);
  //   final todo = iterableTodo.firstOrNull;
  //   if (todo != null) {
  //     final todoEntity = todo.toEntity();
  //     return todoEntity;
  //   }

  //   return null;

  // if(todo != null) {
  //     final resultTodo =
  // }
  // if (todoModel == null) return null;
  // var result = todoModel.toEntity();
  // return result;
  // }

  @override
  Future<void> addTodo(Todo todo) async {
    Todo todoModel = todo;

    // Hive uses the model's type ID (0 in this case) and saves it
    // await _todoBox.put(todoModel.id, todoModel);

    final id = await todoBox.add(todoModel);
    /**
     * After save a new TodoModel
     * 1. Get record from database
     * 2. Update TodoModel.id if localTodo id is equal cero
     * 3. Save todoModel with updated id
     */
    final iterableTodo = todoBox.values.where((model) => model.id == todo.id);
    final localTodo = iterableTodo.firstOrNull;

    if (localTodo != null) {
      // && id == 0) {
      // if(id == 0) {
      todoModel.id = todo.id;
      todoModel.localId = todo.id;

      await todoModel.save();
    }

    return;
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    try {
      List<Todo> todos = [];

      final modelKeys = todoBox.keys.toList();
      for (var key in modelKeys) {
        final todo = await todoBox.get(key);
        if (todo != null) {
          todos.add(todo);
        }
      }

      // await todoBox.close();
      return todos;
    } catch (e) {
      print('Error: Box contains wrong data type for Todo: $e');
      return [];
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    // final todoModel = TodoModel.fromEntity(todo);
    // Use put with the key (ID) to overwrite the existing record
    final iterableTodo = todoBox.values.where((model) => model.id == todo.id);
    var localTodo = iterableTodo.firstOrNull;

    var boxValues = todoBox.values.toList();

    if (localTodo != null) {
      // todoModel.id = todo.id;
      // var localId = localTodo.localId;

      localTodo.todo = todo.todo;
      await localTodo.save();

      // await _todoBox.put(localTodo.key, localTodo);
      // await localTodo.save();
      // await todoModel.save();
      // await _todoBox.put(localId, todoModel);

      var boxValues2 = todoBox.values.toList();

      // await localTodo.save();

      var boxValues3 = todoBox.values.toList();

      // await todoModel.save();
      // await _todoBox.put(todo.id, todoModel);
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    await todoBox.delete(id);
  }

  @override
  bool isBoxEmpty() {
    return todoBox.values.toList().isEmpty;
  }
}
