
import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/utils/constants/app_state_enum.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_action_generator.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

void main() {
  test('should return page action for none', () {
    var expectedPageAction =
        PageAction(state: PageState.replace, page: HomeScreenConfig);
    var pageAction =
        PageActionGenerator().getPageConfigBasedOnState(AppStateEnum.NONE);

    expect(expectedPageAction, pageAction);
  });

}
