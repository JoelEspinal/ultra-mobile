import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/data/database/hive/data_source/todo_local_data_source.dart';
import 'src/data/database/hive/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(TodoModelAdapter()); // The generated adapter
  await TodoLocalDataSourceImpl.initHive(); // Or open the box here

  runApp(const App());
}
