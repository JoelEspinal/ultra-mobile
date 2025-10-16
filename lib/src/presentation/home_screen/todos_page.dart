import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todos_cubit.dart';
import 'todos_state.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todosCubit = context.read<TodosCubit>();
    todosCubit.loadTodos();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // 1. The main scrollable content
            ListView.builder(
              padding: const EdgeInsets.only(
                top: 100,
              ), // Push content down past the floating bar
              itemCount: 50,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Content Item $index'));
              },
            ),

            // 2. The Floating Search Bar
            Positioned(
              top: 20, // Distance from the top of the screen
              left: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Floating Search Bar...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],
        ),

        // RefreshIndicator(
        //   onRefresh: () => todosCubit.loadTodos(),
        //   child: Center(
        //     child: BlocBuilder<TodosCubit, TodosState>(
        //       builder: (context, state) {
        //         if (state.status == TodoStatus.loading) {
        //           return const CircularProgressIndicator();
        //         } else if (state.status == TodoStatus.failure) {
        //           return Text(state.errorMessage);
        //         } else if (state.status == TodoStatus.success) {
        //           return ListView.builder(
        //             itemCount: state.todos.length,
        //             itemBuilder: (context, index) {
        //               final todo = state.todos[index];
        //               return ListTile(
        //                 title: Text(
        //                   todo.todo,
        //                   style: todo.completed
        //                       ? TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           decoration: TextDecoration.lineThrough,
        //                           decorationColor: Colors.black,
        //                           decorationThickness: 2.0,
        //                         )
        //                       : null,
        //                 ),

        //                 leading: IconButton(
        //                   onPressed: () => todosCubit.toggleTodoStatus(todo.id),
        //                   icon: Icon(
        //                     todo.completed
        //                         ? Icons.check_box
        //                         : Icons.check_box_outline_blank,
        //                   ),
        //                 ),
        //               );
        //             },
        //           );
        //         } else {
        //           return const Text('Press the button to load todos.');
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
