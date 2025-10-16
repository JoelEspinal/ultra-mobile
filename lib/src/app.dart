import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra_mobile/src/domain/use_cases/delete_todo_use_case.dart';
import 'presentation/home_screen/todos_cubit.dart';
import 'data/network/todos_api/api_client.dart';
import 'data/network/todos_api/services/todo_service.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/repositories/todo_repository.dart';
import 'domain/use_cases/fetch_todos_use_case.dart';
import 'presentation/home_screen/todos_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>(create: (_) => ApiClient()),
        Provider<TodoService>(
          create: (context) =>
              TodoService(apiClient: context.read<ApiClient>()),
        ),
        Provider<TodoRepository>(
          create: (context) =>
              TodoRepositoryImpl(todoService: context.read<TodoService>()),
        ),
        Provider<FetchTodosUseCase>(
          create: (context) =>
              FetchTodosUseCase(todoRepository: context.read<TodoRepository>()),
        ),
        Provider<DeleteTodoUseCase>(
          create: (context) =>
              DeleteTodoUseCase(todoRepository: context.read<TodoRepository>()),
        ),
      ],
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => TodosCubit(
            context.read<FetchTodosUseCase>(),
            context.read<DeleteTodoUseCase>(),
          ),
          child: const TodosPage(),
        ),
      ),
    );
  }
}
