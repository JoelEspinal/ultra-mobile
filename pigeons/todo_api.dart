import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/data/native/todo_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/example/ultra_mobile/TodoApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.example.ultra_mobile'),
  swiftOut: 'ios/Runner/TodoApi.g.swift',
  swiftOptions: SwiftOptions(),
))

class TodoDetailNative {
  final int id;
  final String? description;
  final String? category;
  final int? priority;
  final int? dueDate; // Milliseconds since epoch
  final String? imageUrl;

  TodoDetailNative({
    required this.id,
    this.description,
    this.category,
    this.priority,
    this.dueDate,
    this.imageUrl,
  });
}

@HostApi()
abstract class TodoNativeApi {
  @async
  TodoDetailNative fetchTodoDetail(int id);
}

@FlutterApi()
abstract class NotificationActionApi {
  void onNotificationAction(int todoId, String action);
}
