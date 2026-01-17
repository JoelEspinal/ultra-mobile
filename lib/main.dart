import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ultra_mobile/src/data/database/hive/models/todo_adapter.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/data/database/hive/models/todo.dart';

void main() async {
  final String todoBoxName = 'todos';

  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
  Hive.init(appDocumentsDir.path);
  await Hive.openBox<Todo>(todoBoxName);
  runApp(const App());
}
