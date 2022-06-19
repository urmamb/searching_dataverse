import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:searching_dataverse/app/app.dart';
import 'package:searching_dataverse/app/globals.dart';
import '../utils/dependency_injection/dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();


  sl.registerLazySingleton(() => Logger());

  runApp(EasyApp());
}
