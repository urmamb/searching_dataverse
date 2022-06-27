import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/utils/constants/app_paths.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/ui_pages.dart';

void main() {
  test('should page action assign values to correct variables', () {
    var pageConfiguration = PageConfiguration(
        key: 'Splash', path: SplashPath, uiPage: Pages.Splash);

    var pageAction = PageAction(
        state: PageState.addPage, page: pageConfiguration, widget: null);
    var pageAction2 = PageAction(
        state: PageState.addAll, page: pageConfiguration, widget: null);
    var pageAction3 = PageAction(
        state: PageState.addPage, page: pageConfiguration, widget: null);

    expect(pageAction, isA<PageAction>());
    expect(pageAction.state, PageState.addPage);
    expect(pageConfiguration, pageAction.page);
    expect(true, pageAction != pageAction2);
    expect(pageAction, pageAction3);
  });
}
