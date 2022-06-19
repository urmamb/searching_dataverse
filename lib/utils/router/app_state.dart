
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

  // ForegroundDynamicLink foregroundDynamicLink;
  // DynamicLinkHandlerFactory dynamicLinkHandlerFactory;

  final List<Page> pages = [];
  AppState();
  // AppState(this.foregroundDynamicLink, this.dynamicLinkHandlerFactory) {
  //   var callbacks = DynamicLinkCallbacks((uri) async {
  //     await generateHandler(uri);
  //   }, (message) {
  //     globalErrorShow?.call(message);
  //   });
  //   foregroundDynamicLink.call(callbacks);
  // }

  // Future<bool> generateHandler(Uri uri) async {
  //   // var handler = await dynamicLinkHandlerFactory.generateLink(uri);
  //   var either = await handler.handle();
  //   if (either.isLeft()) {
  //     either.fold((l) => globalErrorShow?.call(l.message), (r) => null);
  //   }
  //   return either.getOrElse(() => false);
  // }

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

  void moveToNoInternetScreen() {
    currentAction = PageAction(state: PageState.addPage, page: NoInternetPageConfig);
  }

  // void moveToPasscodeBiometricScreen(){
  //   var biometricEnabled = sl.get<UserRuntimeConfig>().biometricAvailable;
  //   if(biometricEnabled){
  //     currentAction = PageAction(state: PageState.replaceAll, page: LocalLoginConfig);
  //   }else{
  //     currentAction = PageAction(state: PageState.replaceAll, page: EnterPasscodeConfig);
  //   }
  // }

  // void moveToEnterMobileNumber(){
  //   currentAction = PageAction(state: PageState.replaceAll, page: GetPhoneAuthConfig);
  // }

  // void moveToWalletScreen() {
  //   GetIt.I.get<HomeViewModel>().controller.index = 0;
  //   currentAction = PageAction(state: PageState.replaceAll, page: HomeScreenConfig);
  // }

  bool canPop() => pages.length > 1;
}
