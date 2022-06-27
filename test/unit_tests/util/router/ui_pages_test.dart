
import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/utils/constants/app_paths.dart';
import 'package:searching_dataverse/utils/router/ui_pages.dart';

void main() {
  test('should page configuration assign values to correct variables', () {
    var pageConfiguration = PageConfiguration(
        key: 'Splash', path: SplashPath, uiPage: Pages.Splash);
    var pageConfiguration2 =
        PageConfiguration(key: 'HomeScreen', path: HomeScreenPath, uiPage: Pages.HomeScreen);
    var pageConfiguration3 =
        PageConfiguration(key: 'HomeScreen', path: HomeScreenPath, uiPage: Pages.HomeScreen);

    expect(pageConfiguration, isA<PageConfiguration>());
    expect(pageConfiguration.key, 'Splash');
    expect(pageConfiguration.path, SplashPath);
    expect(pageConfiguration.uiPage, Pages.Splash);
    expect(true, pageConfiguration != pageConfiguration2);
    expect(pageConfiguration2, pageConfiguration3);
  });
}
