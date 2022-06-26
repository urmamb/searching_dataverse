import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:searching_dataverse/utils/constants/app_paths.dart';

import 'models/page_config.dart';
import 'ui_pages.dart';

class DataverseParser extends RouteInformationParser<PageConfiguration> {

  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(SplashPageConfig);
    }

    final path = '/' + uri.pathSegments[0];

    switch (path) {
      case SplashPath:
        return SynchronousFuture(SplashPageConfig);

      default:
        return SynchronousFuture(SplashPageConfig);
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);

      case Pages.HomeScreen:
        return const RouteInformation(location: HomeScreenPath);

      case Pages.NoInternetScreen:
        return const RouteInformation(location: NoInternetScreenPath);
      case Pages.SearchViewScreen:
        return const RouteInformation(location: SearchViewScreenPath);
    }
  }
}
