import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/src/features/splash_screen/splash_screen_view_model.dart';
import 'package:searching_dataverse/src/features/splash_screen/usecase/check_access_token.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

import '../../../mocks/mock_repository.dart';



void main() {
  late SplashScreenViewModel viewModel;
  late AppState appState;
  late CheckAccessToken checkAccessToken;
  late Repository repository;


  setUp(() {
    appState = AppState();
    repository = MockRepository();
    checkAccessToken = CheckAccessToken(repository);
    viewModel = SplashScreenViewModel(appState: appState, checkAccessToken: checkAccessToken);
    // GetIt.I.registerSingleton(viewModel);
  });

  tearDown((){
    GetIt.I.reset();
  });

  test('should successfuly move to home screen', () async {
    // arrange
    var expectedPageAction = PageAction(state: PageState.replaceAll, page: HomeScreenConfig);

    // act
    viewModel.moveToHomeScreen();

    // assert
    expect(expectedPageAction, appState.currentAction);
  });


  test('should handle error ', () async {
    var errorResponse = false;

    viewModel.errorMessages = (value) {
      errorResponse = true;
    };

    viewModel.handleError(Left(ServerFailure(SOMETHING_WENT_WRONG)));

    expect(true, errorResponse);
  });
}
