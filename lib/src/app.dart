import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultra_mobile/src/data/network/todos_api/api_client.dart';
import 'package:ultra_mobile/src/data/network/todos_api/services/todo_service.dart';
import 'package:ultra_mobile/src/presentation/home_screen/home_screen.dart';

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
      ],
      child: MaterialApp(home: Scaffold(body: HomeScreen())),
    );
  }
}
