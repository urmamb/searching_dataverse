import 'dart:async';
import 'package:searching_dataverse/app/globals.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import '../utils/dependency_injection/dependency_injection.dart' as di;
import '../app/app.dart';
import 'package:flutter/services.dart';


/// Our development app start from here
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'env/.env_development');
  await di.init();


  await SystemChrome.setPreferredOrientations(await [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  sl.registerLazySingleton(() => Logger(
    filter: ShowAllLogsFilter()
  ));


  runZonedGuarded(() {
    runApp(DevicePreview(
        builder: (context) => const EasyApp(
              key: ValueKey('development'),
            ),
        enabled: false));
  }, (error, stackTrace) => Logger().wtf(error.toString(), stackTrace));
}






class ShowAllLogsFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}