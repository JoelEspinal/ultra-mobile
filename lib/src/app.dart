import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ultra_mobile/src/domain/use_cases/local_use_cases/toggle_completed_todo_use_case.dart';

import '../../src/domain/entities/todo.dart' as entity_todo;
import 'data/database/hive/data_source/todo_local_data_source.dart';
import 'data/network/todos_api/api_client.dart';
import 'data/network/todos_api/services/remote_todo_service.dart';
import 'data/repositories/local_todo_repository_impl.dart';
import 'data/repositories/remote_todo_repository_impl.dart';
import 'domain/repositories/local_todo_repository.dart';
import 'domain/repositories/remote_todo_repository.dart';
import 'domain/use_cases/local_use_cases/delete_todo_use_case.dart';
import 'domain/use_cases/local_use_cases/fetch_todo_list_from_hive_use_case.dart';
import 'domain/use_cases/local_use_cases/save_todo_list_use_case.dart';
import 'domain/use_cases/local_use_cases/toggle_favorite_todo_use_case.dart';
import 'domain/use_cases/local_use_cases/update_todo_use_case.dart';
import 'domain/use_cases/sync_todos_use_case.dart';
import 'presentation/start_up/splash_screen.dart';
import 'presentation/start_up/start_up_cubit.dart';
import 'presentation/todo_details_screen/todo_details_cubit.dart';
import 'presentation/todo_details_screen/todo_details_page.dart';
import 'presentation/todos_screen/todos_cubit.dart';
import 'presentation/todos_screen/todos_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>(create: (_) => ApiClient()),
        Provider<RemoteTodoService>(
          create: (context) =>
              RemoteTodoService(apiClient: context.read<ApiClient>()),
        ),
        Provider<RemoteTodoRepository>(
          create: (context) => RemoteTodoRepositoryImpl(
              remoteTodoService: context.read<RemoteTodoService>()),
        ),
        Provider<TodoLocalDataSource>(
          create: (context) => TodoLocalDataSource(),
        ),
        Provider<LocalPersistenceRepository>(
          create: (context) => LocalPersistenceRepositoryImpl(
              localDataSource: context.read<TodoLocalDataSource>()),
        ),
        Provider<FetchLocalTodoUseCase>(
          create: (context) => FetchLocalTodoUseCase(
              localPersistenceRepository:
                  context.read<LocalPersistenceRepository>()),
        ),
        Provider<SaveTodoListUseCase>(
          create: (context) => SaveTodoListUseCase(
              localPersistenceRepository:
                  context.read<LocalPersistenceRepository>()),
        ),
        Provider<DeleteTodoUseCase>(
          create: (context) => DeleteTodoUseCase(
              localPersistenceRepository:
                  context.read<LocalPersistenceRepository>()),
        ),
        Provider<UpdateTodoUseCase>(
          create: (context) => UpdateTodoUseCase(
              persistenceRepository:
                  context.read<LocalPersistenceRepository>()),
        ),
        Provider<ToggleFavoriteTodoUseCase>(
          create: (context) => ToggleFavoriteTodoUseCase(
            localPersistenceRepository:
                context.read<LocalPersistenceRepository>(),
          ),
        ),
        Provider<ToggleCompleteTodoUseCase>(
          create: (context) => ToggleCompleteTodoUseCase(
            localPersistenceRepository:
                context.read<LocalPersistenceRepository>(),
          ),
        ),
        Provider<SyncTodosUseCase>(
          create: (context) => SyncTodosUseCase(
              remoteRepository: context.read<RemoteTodoRepository>(),
              localPersistenceRepository:
                  context.read<LocalPersistenceRepository>()),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => BlocProvider(
                create: (context) {
                  return StartupCubit(
                    syncTodosUseCase: context.read<SyncTodosUseCase>(),
                  );
                },
                child: const SplashScreen(),
              ),
          '/home': (context) => BlocProvider(
                create: (context) {
                  return TodosCubit(
                    fetchLocalTodoUseCase:
                        context.read<FetchLocalTodoUseCase>(),
                    deleteTodoUseCase: context.read<DeleteTodoUseCase>(),
                    toggleFavoriteTodoUseCase:
                        context.read<ToggleFavoriteTodoUseCase>(),
                    toggleCompleteTodoUseCase:
                        context.read<ToggleCompleteTodoUseCase>(),
                  );
                },
                child: const TodosPage(),
                // ),
              ), //..loadTodos(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/todoDetail') {
            final todo = settings.arguments as entity_todo.Todo;
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TodoDetailCubit(
                    updateTodoUseCase: context.read<UpdateTodoUseCase>()),
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
