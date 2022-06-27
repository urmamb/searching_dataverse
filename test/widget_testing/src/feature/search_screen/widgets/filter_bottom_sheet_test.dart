

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:searching_dataverse/services/repository/repository.dart';
import 'package:searching_dataverse/src/features/home/landing/usecase/logout_user.dart';
import 'package:searching_dataverse/src/features/home/search_screen/model/search_screen_view_model.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';
import 'package:searching_dataverse/src/features/home/search_screen/widgets/filter_bottom_sheet.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';

import '../../../../../unit_tests/mocks/mock_repository.dart';
import '../../../../../unit_tests/src/helper/size_extension.dart';

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

  testWidgets('should display bottomsheet when button clicked',
        (tester) async {

      await tester.testAppForWidgetTesting(MaterialApp(
        home: Material(
          child: Builder(builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  FilterAccountsBottomSheet(context).show();
                },
                child: Text('Go'),
              ),
            );
          }),
        ),
      ));

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Filter Accounts'), findsOneWidget);
      expect(find.text('Filter by Account State'), findsOneWidget);
      expect(find.text('Filter by State/Province'), findsOneWidget);
    },
  );

  testWidgets('should change when select new view',
          (WidgetTester tester) async {
        await tester.setScreenSize();
        await tester.testAppForWidgetTesting(MaterialApp(
          home: Material(
            child: Builder(builder: (context) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    FilterAccountsBottomSheet(context).show();
                  },
                  child: Text('Go'),
                ),
              );
            }),
          ),
        ));

        await tester.tap(find.text('Go'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Alabama'), warnIfMissed: false);
        await tester.scrollUntilVisible(find.text('New York'), 200);
        expect(find.text('New York'), findsOneWidget);

        await tester.pump(Duration(seconds: 5));
        expect('Alabama', viewModel.selectedStatesList.value.first.stateName);
      });
}
