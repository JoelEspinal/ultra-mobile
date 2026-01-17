import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra_mobile/src/domain/entities/todo.dart';

import '../widgets/show_bottom_confirmation_sheet.dart';
import 'todos_cubit.dart';
import 'todos_state.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              // child: RefreshIndicator(
              // onRefresh: () async => context.read<TodosCubit>().loadTodos(),
              child: Center(
                child: BlocBuilder<TodosCubit, TodosState>(
                  builder: (context, state) {
                    if (state.status == TodoStatus.initial) {
                      return CircularProgressIndicator();
                    }
                    if (state.status == TodoStatus.loading) {
                      return const CircularProgressIndicator();
                    } else if (state.status == TodoStatus.failure) {
                      return Text(state.errorMessage);
                    } else if (state.status == TodoStatus.success) {
                      return RefreshIndicator(
                        onRefresh: () async =>
                            context.read<TodosCubit>().loadTodos(),
                        child: ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) {
                            // final todo = state.todos[index];
                            return Dismissible(
                              key: Key(state.todos[index].id.toString()),
                              background: Container(color: Colors.red),
                              confirmDismiss: (direction) async {
                                showBottomConfirmationSheet(
                                  context,
                                  onConfirm: () async {
                                    context
                                        .read<TodosCubit>()
                                        .deleteTodo(state.todos[index].id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Deleted "${state.todos[index].task}"'),
                                      ),
                                    );
                                  },
                                );
                                return null;
                              },
                              child: SizedBox(
                                height: 100.0,
                                child: ListTile(
                                  onTap: () async {
                                    await _goToTodoDetail(
                                        context, state.todos[index]);
                                  },
                                  title: Text(
                                    state.todos[index].task,
                                    style: state.todos[index].completed
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
                                    onPressed: () => context
                                        .read<TodosCubit>()
                                        .toggleTodoStatus(
                                            state.todos[index].id),
                                    icon: Icon(
                                      state.todos[index].completed
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      context.read<TodosCubit>().toggleFavorite(
                                            state.todos[index].id,
                                          );
                                    },
                                    icon: Icon(
                                      (state.todos[index].isFavorite != null &&
                                              state.todos[index].isFavorite ==
                                                  true)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amberAccent,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text('Press the button to load todos.');
                    }
                  },
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
                  onChanged: (value) async =>
                      await context.read<TodosCubit>().loadTodos(value),
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

  Future<void> _goToTodoDetail(BuildContext context, Todo todo) async {
    final result = await Navigator.pushNamed(
      context,
      '/todoDetail',
      arguments: todo,
    );

    if (context.mounted && result == true) {
      await context.read<TodosCubit>().loadTodos();
    }
  }
}
