
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/utils/constants/app_state_enum.dart';

import 'models/page_action.dart';
import 'models/page_config.dart';

/// Pages states
enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

/// This class contains the global state of the app
class AppState extends ChangeNotifier {
  AppStateEnum appStateEnum = AppStateEnum.NONE;

  final List<Page> pages = [];
  AppState();

  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;

  ValueChanged<String>? globalErrorShow;

  /// This method resets your page action
  void resetCurrentAction() {
    _currentAction = PageAction(state: PageState.replaceAll, page: SplashPageConfig);
  }

  /// this method is used to change the page of the app
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  void moveToBackScreen() {
    currentAction = PageAction(state: PageState.pop);
  }

  bool canPop() => pages.length > 1;
}
