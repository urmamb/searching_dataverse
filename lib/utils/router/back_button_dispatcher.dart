import 'package:flutter/material.dart';

import 'app_state.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppState appState;



  VoidCallback? backCallback;

  AppBackButtonDispatcher(this.appState) : super();

  @override
  Future<bool> didPopRoute() async {

    if(backCallback == null){
      appState.moveToBackScreen();
    } else {
      backCallback?.call();
    }

    return true;
  }
}
