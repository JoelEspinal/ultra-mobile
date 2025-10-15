import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/network/todos_api/services/todo_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoService = context.read<TodoService>();

    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            // TodosResponse todosResponse = await todoService.fetchTodos();
            // print(todosResponse.todos.toString());

            var todo = await todoService.fetchTodo(1);

            // print(todo.todo);
          },
          child: Text("FETCH single TODOS"),
        ),
      ),
    );
  }
}
