import 'package:flutter/material.dart';

import 'app_state.dart';

class CasheroBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppState appState;



  VoidCallback? backCallback;

  CasheroBackButtonDispatcher(this.appState) : super();

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
