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
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: RefreshIndicator(
                onRefresh: () => todosCubit.loadTodos(),
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
                          itemBuilder: (context, index) {
                            final todo = state.todos[index];
                            return Dismissible(
                              key: Key(todo.id.toString()),
                              background: Container(color: Colors.red),
                              onDismissed: (direction) {
                                todosCubit.deleteTodo(todo.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Deleted "${todo.todo}"'),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 100.0,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/todoDetail',
                                      arguments: todo,
                                    );
                                  },
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
                                  trailing: IconButton(
                                    onPressed: () {
                                      context.read<TodosCubit>().toggleFavorite(
                                        todo.id,
                                      );
                                    },
                                    icon: Icon(
                                      (todo.isFavorite != null &&
                                              todo.isFavorite == true)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amberAccent,
                                    ),
                                  ),
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
              ),
            ),
            Positioned(
              top: 20,
              left: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) => todosCubit.loadTodos(value),
                  decoration: InputDecoration(
                    hintText: " Search todo ...",
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
