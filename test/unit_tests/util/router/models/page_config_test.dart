import 'package:flutter_test/flutter_test.dart';
import 'package:searching_dataverse/utils/router/models/page_config.dart';

void main() {
  group('config test', () {
    test('should equal two references of splash config', () {
      expect(SplashPageConfig, SplashPageConfig);
    });

    test('should equal two references of home screen config', () {
      expect(HomeScreenConfig, HomeScreenConfig);
    });

    test('should equal two references of search view config', () {
      expect(SearchViewScreenConfig, SearchViewScreenConfig);
    });
  });
}
