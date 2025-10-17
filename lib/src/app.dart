import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/database/hive/data_source/todo_local_data_source.dart';
import 'data/repositories/persistence_repository_impl.dart';
import 'domain/repositories/persistence_repository.dart';
import 'domain/use_cases/delete_todo_use_case.dart';
import 'domain/use_cases/update_todo_use_case.dart';
import 'presentation/todo_screen/todo_detail_cubit.dart';
import 'presentation/todo_screen/todo_detail_page.dart';

import '../../src/domain/entities/todo.dart' as entity_todo;
import 'data/network/todos_api/api_client.dart';
import 'data/network/todos_api/services/todo_service.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/repositories/todo_repository.dart';
import 'domain/use_cases/fetch_todos_use_case.dart';
import 'presentation/todos_screen/todos_cubit.dart';
import 'presentation/todos_screen/todos_page.dart';

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
        Provider<TodoLocalDataSource>(
          create: (context) => TodoLocalDataSourceImpl(),
        ),
        Provider<PersistenceRepository>(
          create: (context) => PersistenceRepositoryImpl(
              localDataSource: context.read<TodoLocalDataSource>()),
        ),
        Provider<FetchTodosUseCase>(
          create: (context) => FetchTodosUseCase(
              todoRepository: context.read<TodoRepository>(),
              persistenceRepository: context.read<PersistenceRepository>()),
        ),
        Provider<DeleteTodoUseCase>(
          create: (context) =>
              DeleteTodoUseCase(todoRepository: context.read<TodoRepository>()),
        ),
        Provider<UpdateTodoUseCase>(
          create: (context) =>
              UpdateTodoUseCase(todoRepository: context.read<TodoRepository>()),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => BlocProvider(
                create: (context) => TodosCubit(
                  context.read<FetchTodosUseCase>(),
                  context.read<DeleteTodoUseCase>(),
                ),
                child: const TodosPage(),
              ),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/todoDetail') {
            final todo = settings.arguments as entity_todo.Todo;
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TodoDetailCubit(),
                child: TodoDetailPage(todo: todo),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
