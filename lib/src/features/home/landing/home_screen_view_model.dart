import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/app/widgets/show_loader.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/usecase/usecases/usecase.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/get_access_token.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/login_user.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

class HomeScreenViewModel {
  final GetAccessToken _getAccessToken;
  final LogInUser _logInUser;
  final AppState _appState;

  HomeScreenViewModel({required GetAccessToken getAccessToken, required LogInUser logInUser, required AppState appState})
      : _getAccessToken = getAccessToken,
        _logInUser = logInUser,
        _appState = appState;

  ValueChanged<String>? errorMessageNotifier;
  VoidCallback? toggleShowLoader;

  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) {
      if(l is AccessTokenFailure){
        loginUser();
        return;
      }
      toggleShowLoader?.call();
      errorMessageNotifier?.call(l.message);
    }, (r) => null);
  }


  Future<void> loginUser() async {
    var loginUserEither = await _logInUser.call(NoParams());

    if (loginUserEither.isLeft()) {
      handleError(loginUserEither);
      return;
    }

    await getAccessToken();
  }

  Future<void> getAccessToken() async {
    var getAccessTokenEither = await _getAccessToken.call(NoParams());

    if (getAccessTokenEither.isLeft()) {
      handleError(getAccessTokenEither);
      return;
    }
    toggleShowLoader?.call();

    moveToSearchScreen();
  }

  void moveToSearchScreen(){
    _appState.currentAction = PageAction(state: PageState.addPage, page: SearchViewScreenConfig);
  }

  void moveToLoginFailedScreen(){

  }
}
