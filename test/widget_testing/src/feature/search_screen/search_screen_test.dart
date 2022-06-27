import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/logout_user.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/search_screen/search_view_screen.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';

import '../../../../unit_tests/mocks/mock_repository.dart';
import '../../../../unit_tests/src/helper/size_extension.dart';

void main() {
  late SearchScreenViewModel viewModel;
  late Repository repository;
  late LogOutUser logOutUser;
  late AppState appState;
  late GetAccounts getAccounts;


  setUp(() {
    repository = MockRepository();
    logOutUser = LogOutUser(repository);
    getAccounts = GetAccounts(repository);
    appState = AppState();
    viewModel = SearchScreenViewModel( appState: appState, getAccounts: getAccounts, logOutUser: logOutUser);

    GetIt.I.registerSingleton(viewModel);

  });

  testWidgets('Should show loading contents of search screen', (tester) async {
    final textKeyFinder = find.byKey(const Key('account_loading'));

    await tester.testAppForWidgetTesting(
      ChangeNotifierProvider<SearchScreenViewModel>.value(value: viewModel, child: const SearchViewScreen()),
    );

    expect(textKeyFinder, findsOneWidget);
  });

  testWidgets('Should go back on tapping back button', (tester) async {
    var expectedPageAction = PageAction(state: PageState.pop);
    final accessKeyFinder = find.byKey(const Key('back_button'));

    await tester.testAppForWidgetTesting(
      ChangeNotifierProvider<SearchScreenViewModel>.value(value: viewModel, child: const SearchViewScreen()),
    );

    await tester.tap(accessKeyFinder);

    expect(appState.currentAction, expectedPageAction);
  });

  testWidgets('Should show contents of search screen when search string is empty', (tester) async {
    final textFinder = find.text('Search account');
    final textFinder2 = find.text('No result found');

    viewModel.searchController.text = 'blablabla';

    await tester.testAppForWidgetTesting(
      ChangeNotifierProvider<SearchScreenViewModel>.value(value: viewModel, child: const SearchViewScreenContent()),
    );

    expect(textFinder, findsOneWidget);
    expect(textFinder2, findsOneWidget);
  });

  testWidgets('Should show contents of search screen when accounts available', (tester) async {
    final accountsWidgetFinder = find.byKey(const Key('accounts_widget'));
    final textFinder = find.text('Accounts on dataverse');
    final textFinder2 = find.text('Filter');

    await viewModel.fetchAccountsTable();

    await tester.testAppForWidgetTesting(
      ChangeNotifierProvider<SearchScreenViewModel>.value(value: viewModel, child: const Material(child: SearchViewScreenContent())),
    );


    expect(accountsWidgetFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
    expect(textFinder2, findsOneWidget);
  });

  // testWidgets('Should show move to search screen on button tap', (tester) async {
  //   var expectedPageAction = PageAction(state: PageState.addPage, page: SearchViewScreenConfig);
  //
  //   final accessKeyFinder = find.byKey(const Key('access_button'));
  //
  //   await tester.testAppForWidgetTesting(
  //     Provider.value(value: viewModel, child: const HomeScreen()),
  //   );
  //
  //   await tester.tap(accessKeyFinder);
  //
  //   expect(appState.currentAction, expectedPageAction);
  //   expect(accessKeyFinder, findsOneWidget);
  // });
}
