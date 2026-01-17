import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/data/native/todo_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/example/ultra_mobile/TodoApi.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/TodoApi.g.swift',
  swiftOptions: SwiftOptions(),
))

class PigeonTodoDetail {
  final int id;
  final String? description;
  final String? category;
  final int? priority;
  final int? dueDate; // Milliseconds since epoch
  final String? imageUrl;

  PigeonTodoDetail({
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
  PigeonTodoDetail fetchTodoDetail(int id);
}

@FlutterApi()
abstract class NotificationActionApi {
  void onNotificationAction(int todoId, String action);
}
