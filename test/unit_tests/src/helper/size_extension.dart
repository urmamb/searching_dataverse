
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/app/globals.dart';

extension SetScreenSize on WidgetTester {
  Future<void> setScreenSize({double width = 540, double height = 960, double pixelDensity = 1}) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = pixelDensity;
  }

  Future testAppForWidgetTesting(Widget child, {Duration duration = Duration.zero}) {
    return pumpWidget(Builder(builder: (context) {
      return ScreenUtilInit(
          // designSize: Size(540.0, 960.0),
          builder: (context, mychild) {
            return MaterialApp(
              navigatorKey: navigatorKeyGlobal,
              theme: ThemeData(),
              home: Builder(builder: (_context) {
                return child;
              }),
            );
          });
    }), duration);
  }
}
