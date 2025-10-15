import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultra_mobile/src/data/network/todos_api/models/todo_response.dart';
import 'package:ultra_mobile/src/data/network/todos_api/services/todo_service.dart';

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

            // String response = await todoService.deleteTodo(1);
            // print(response);
          },
          child: Text("FETCH TODOS"),
        ),
      ),
    );
  }
}
