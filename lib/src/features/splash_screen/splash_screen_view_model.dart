import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/splash_screen/usecase/check_access_token.dart';
import 'package:searching_dataverse/utils/constants/app_state_enum.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final AppState _appState;
  final CheckAccessToken _checkAccessToken;


  SplashScreenViewModel({ required AppState appState, required CheckAccessToken checkAccessToken})
      :_appState = appState,
        _checkAccessToken = checkAccessToken;

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

  void moveToSearchScreen() {
    _appState.currentAction =
        PageAction(state: PageState.replaceAll, page: SearchViewScreenConfig);
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


  bool isNotInternetConnection(Failure failure) => failure is NetworkFailure;

  bool isAccessTokenExpired(Failure l) => l is AccessTokenFailure;

  void checkInternetConnection() {}

  Future<bool> checkAccessTokenAvailable() async{
    var checkTokenAvailableEither = await _checkAccessToken.call(NoParams());

    if(checkTokenAvailableEither.isLeft()){
      return false;
    }

    return true;
  }
}
