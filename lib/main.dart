import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'src/app.dart';
import 'src/data/database/hive/data_source/todo_local_data_source.dart';
// import 'src/data/database/hive/models/odo_model.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = Directory.current.path;
  print("----------------------");
  // print(appDocumentDir.path);
  print("----------------------");

  // Hive
  // ..init(appDocumentDir.path)
  await Hive.initFlutter();
  Hive
    ..init(path)
    ..registerAdapter(TodoModelAdapter());

  await TodoLocalDataSourceImpl.init();

  runApp(const App());
}
