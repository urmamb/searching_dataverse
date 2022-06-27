import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

void main() {
  test('should set current page action be equal to supplied page action', () {
    var appState =
        AppState();

    var pageAction =
        PageAction(state: PageState.addPage, page: SplashPageConfig);
    appState.currentAction = pageAction;

    expect(pageAction, appState.currentAction);
  });

  test('should reset page action', () {

    var appState =
        AppState();

    var pageAction = PageAction(state: PageState.addPage, page: HomeScreenConfig);
    var defaultAction =
        PageAction(state: PageState.replaceAll, page: SplashPageConfig);

    appState.currentAction = pageAction;
    appState.resetCurrentAction();

    expect(defaultAction, appState.currentAction);
  });
}
