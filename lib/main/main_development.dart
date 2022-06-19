import 'dart:async';
import 'dart:io';

import 'package:searching_dataverse/app/globals.dart';
// import 'package:searching_dataverse/my_app/models/cashero_contacts.dart';
// import 'package:searching_dataverse/services/remote_config/remote_config_service.dart';
import 'package:device_preview/device_preview.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import '../utils/dependency_injection/dependency_injection.dart' as di;
import '../app/app.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';


/// Our development app start from here
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dotenv.load(fileName: 'env/.env_development');
  await di.init();
  // await EasyLocalization.ensureInitialized();


  await SystemChrome.setPreferredOrientations(await [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // await sl<RemoteConfigService>().initialise();

  // await sl.isReady<Box<CasheroContacts>>();

  // if(Platform.isIOS){
  //   await FlutterDownloader.initialize(
  //       debug: true
  //   );
  // }

  sl.registerLazySingleton(() => Logger(
    filter: ShowAllLogsFilter()
  ));


  runZonedGuarded(() {
    runApp(DevicePreview(
        builder: (context) => EasyApp(
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