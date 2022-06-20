import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/app/app_usecase/clear_secure_storage.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/utils/constants/app_state_enum.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final ClearSecureStorage _clearSecureStorage;
  final AppState _appState;


  SplashScreenViewModel({required ClearSecureStorage clearSecureStorage, required AppState appState})
      : _clearSecureStorage = clearSecureStorage,
        _appState = appState;

  late ValueChanged<String> errorMessages;
  late VoidCallback showInternetSnackBar;
  VoidCallback? startConfiguration;
  VoidCallback? showPermissionDialog;

  bool shouldOnBoard = false;
  AppStateEnum appStateEnum = AppStateEnum.NONE;
  bool accessTokenExpiredNeedAuth = false;
  bool userExistsOnServer = false;
  String userStatus = 'ENABLED';

  int maxSteps = 8;

  ValueNotifier<int> currentProgressNotifier = ValueNotifier(0);


  /// This method is used for doing all the configurations needed for the app
  void moveToHomeScreen() {
    _appState.currentAction =
        PageAction(state: PageState.replaceAll, page: HomeScreenConfig);
  }

  void handleError(Either<Failure, dynamic> response) {
    response.fold((l) {
      if (l is NetworkFailure) {
        showInternetSnackBar.call();
      } else {
        errorMessages.call(l.message);
      }
    }, (r) => null);
  }

  @visibleForTesting
  Future<bool> clearSecureStorageData() async {
    var clearSecureStorageEither = await _clearSecureStorage.call(NoParams());

    if (clearSecureStorageEither.isRight()) {
      return true;
    }
    return false;
  }

  bool isNotInternetConnection(Failure failure) => failure is NetworkFailure;

  bool isAccessTokenExpired(Failure l) => l is AccessTokenFailure;

  void checkInternetConnection() {}
}
