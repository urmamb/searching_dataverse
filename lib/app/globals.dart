import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GlobalKey<NavigatorState> navigatorKeyGlobal = GlobalKey();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerGlobal = GlobalKey();
final sl = GetIt.instance;
bool isAndroid = false;