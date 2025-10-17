import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/data/database/hive/data_source/todo_local_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await TodoLocalDataSourceImpl.initHive(); // Or open the box here

  runApp(const App());
}
