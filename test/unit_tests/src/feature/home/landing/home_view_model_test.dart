import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/src/features/home/landing/home_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/get_access_token.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/login_user.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

import '../../../../mocks/mock_error_repository.dart';
import '../../../../mocks/mock_repository.dart';

void main() {
  late HomeScreenViewModel viewModel;
  late Repository repository;
  late Repository errorRepository;
  late GetAccessToken getAccessToken;
  late LogInUser logInUser;
  late AppState appState;


  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
    getAccessToken = GetAccessToken(repository);
    logInUser = LogInUser(repository);
    appState = AppState();
    viewModel = HomeScreenViewModel(getAccessToken: getAccessToken, logInUser: logInUser, appState: appState);
    // GetIt.I.registerSingleton(viewModel);
  });

  tearDown((){
    GetIt.I.reset();
  });

  test('should successfuly get token and move to search account page', () async {
    // arrange
    var expectedPageAction = PageAction(state: PageState.addPage, page: SearchViewScreenConfig);

    // act
    await viewModel.loginUser();

    // assert
    expect(expectedPageAction, appState.currentAction);
  });

  test('should return something went wrong from repository', () async {
    // arrange
    var logInUser = LogInUser(errorRepository);
    viewModel = HomeScreenViewModel(getAccessToken: getAccessToken, logInUser: logInUser, appState: appState);


    // act
    await viewModel.getAccessToken();

    // assert
    viewModel.errorMessageNotifier = (value) {
      expect(SOMETHING_WENT_WRONG, value);
    };
  });


  test('should handle error ', () async {
    var errorResponse = false;

    viewModel.errorMessageNotifier = (value) {
      errorResponse = true;
    };

    viewModel.handleError(Left(ServerFailure(SOMETHING_WENT_WRONG)));

    expect(true, errorResponse);
  });
}
