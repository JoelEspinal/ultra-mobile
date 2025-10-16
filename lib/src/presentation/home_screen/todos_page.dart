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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap:
                  false, // Make the AppBar snap completely into view or hide completely
              // A standard AppBar height, but it will hide/show on scroll
              toolbarHeight: 60.0,
              // The actual search bar UI is placed in the title/flexibleSpace
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Todo...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return RefreshIndicator(
                  child: Center(
                    child: BlocBuilder<TodosCubit, TodosState>(
                      builder: (context, state) {
                        if (state.status == TodoStatus.loading) {
                          return const CircularProgressIndicator();
                        } else if (state.status == TodoStatus.failure) {
                          return Text(state.errorMessage);
                        } else if (state.status == TodoStatus.success) {
                          return ListView.builder(
                            itemCount: state.todos.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final todo = state.todos[index];
                              return ListTile(
                                title: Text(
                                  todo.todo,
                                  style: todo.completed
                                      ? TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.black,
                                          decorationThickness: 2.0,
                                        )
                                      : null,
                                ),

                                leading: IconButton(
                                  onPressed: () =>
                                      todosCubit.toggleTodoStatus(todo.id),
                                  icon: Icon(
                                    todo.completed
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text('Press the button to load todos.');
                        }
                      },
                    ),
                  ),
                  onRefresh: () => todosCubit.loadTodos(),
                );
              }, childCount: 1),
            ),
          ],

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
          //                   onPressed: () =>
          //                       todosCubit.toggleTodoStatus(todo.id),
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
      ),
    );
  }
}
