import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/logout_user.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/state_list.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/utils/constants/app_strings.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';

import '../../../../mocks/mock_constants.dart';
import '../../../../mocks/mock_error_repository.dart';
import '../../../../mocks/mock_repository.dart';

void main() {
  late SearchScreenViewModel viewModel;
  late Repository repository;
  late Repository errorRepository;
  late LogOutUser logOutUser;
  late AppState appState;
  late GetAccounts getAccounts;


  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
    logOutUser = LogOutUser(repository);
    getAccounts = GetAccounts(repository);
    appState = AppState();
    viewModel = SearchScreenViewModel( appState: appState, getAccounts: getAccounts, logOutUser: logOutUser);
  });

  tearDown((){
    GetIt.I.reset();
  });

  test('should successfuly get token and move to search account page', () async {
    // arrange
    var expectedPageAction = PageAction(state: PageState.pop);

    // act
    await viewModel.logout();

    // assert
    expect(expectedPageAction, appState.currentAction);
  });

  test('should return error on fetching accounts', () async {
    // arrange
    var getAccounts = GetAccounts(errorRepository);
    var viewModel = SearchScreenViewModel( appState: appState, getAccounts: getAccounts, logOutUser: logOutUser);

    // act
    await viewModel.fetchAccountsTable();

    // assert
    viewModel.errorMessageNotifier = (value) {
      expect(SOMETHING_WENT_WRONG, value);
    };
  });

  test('should successfuly get token and move to search account page', () async {
    // arrange

    // act
    await viewModel.fetchAccountsTable();

    // assert
    expect(MOCK_ACCOUNT_LIST, viewModel.accounts.value);
  });

  test('should successfuly get token and move to search account page', () async {
    // arrange
    viewModel.searchController.text = 'markus';
    // act
    await viewModel.fetchAccountsTable();
    viewModel.changeSearchString();

    // assert
    expect(MOCK_ACCOUNT_LIST.first.accountnumber, viewModel.accounts.value.first.accountnumber);
  });

  test('should successfuly filter accounts for ', () async {
    // arrange
    viewModel.searchController.text = 'markus';
    // act
    viewModel.onTapState(UsState(stateCode: 'NY', stateName: 'New York'));

    // assert
    expect(MOCK_ACCOUNT_LIST.first.address1_city, 'New York');
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
