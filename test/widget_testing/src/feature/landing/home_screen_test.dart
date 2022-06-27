import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/src/features/home/landing/home_screen.dart';
import 'package:searching_dataverse/src/features/home/landing/home_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/get_access_token.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/login_user.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

import '../../../../unit_tests/mocks/mock_repository.dart';
import '../../../../unit_tests/src/helper/size_extension.dart';

void main() {
  late HomeScreenViewModel viewModel;
  late Repository repository;
  late GetAccessToken getAccessToken;
  late LogInUser logInUser;
  late AppState appState;

  setUpAll(() {
    repository = MockRepository();
    getAccessToken = GetAccessToken(repository);
    logInUser = LogInUser(repository);
    appState = AppState();
    viewModel = HomeScreenViewModel(getAccessToken: getAccessToken, logInUser: logInUser, appState: appState);
    GetIt.I.registerSingleton(viewModel);
  });

  testWidgets('Should show contents of home screen', (tester) async {
    final textKeyFinder = find.byKey(const Key('description_text'));
    final accessKeyFinder = find.byKey(const Key('access_button'));
    final textFinder = find.text('Access Dataverse');

    await tester.testAppForWidgetTesting(
      Provider.value(value: viewModel, child: const HomeScreen()),
    );

    expect(textKeyFinder, findsOneWidget);
    expect(accessKeyFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Should show move to search screen on button tap', (tester) async {
    var expectedPageAction = PageAction(state: PageState.addPage, page: SearchViewScreenConfig);

    final accessKeyFinder = find.byKey(const Key('access_button'));

    await tester.testAppForWidgetTesting(
      Provider.value(value: viewModel, child: const HomeScreen()),
    );

    await tester.tap(accessKeyFinder);

    expect(appState.currentAction, expectedPageAction);
    expect(accessKeyFinder, findsOneWidget);
  });
}
