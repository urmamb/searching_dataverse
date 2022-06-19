import 'package:logger/logger.dart';
import 'package:searching_dataverse/utils/constants/app_state_enum.dart';
import 'package:searching_dataverse/utils/router/models/page_action.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

import '../app_state.dart';

class PageActionGenerator {
  PageAction getPageConfigBasedOnState(AppStateEnum appStateEnum) {
    var log = Logger();

    log.i(appStateEnum);

    switch (appStateEnum) {
      case AppStateEnum.NONE:
        // return PageAction(state: PageState.replaceAll, page: GetPhoneAuthConfig);
        break;

    }

    return PageAction(state: PageState.replace, page: HomeScreenConfig);
  }
}
