import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/utils/router/back_button_dispatcher.dart';
import 'package:searching_dataverse/utils/router/dataverse_route_parser.dart';
import 'package:flutter/material.dart';

import '../utils/router/dataverse_router_delegate.dart';

class EasyApp extends StatefulWidget {
  const EasyApp({Key? key}) : super(key: key);

  @override
  _EasyAppState createState() => _EasyAppState();
}

class _EasyAppState extends State<EasyApp> {
  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late DataverseRouterDelegate delegate;
  late AppBackButtonDispatcher backButtonDispatcher;
  late DataverseParser parser = DataverseParser();

  @override
  void initState() {
    super.initState();


    delegate = DataverseRouterDelegate(sl());
    backButtonDispatcher = sl<AppBackButtonDispatcher>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),

        builder: (context, child) {
      return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerGlobal,
          routerDelegate: delegate,
          backButtonDispatcher: backButtonDispatcher,
          routeInformationParser: parser,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget ?? Container(),
            );
          },
          title: 'Searching Dataverse',
          theme: ThemeData());
    });
  }
}
