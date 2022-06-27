import 'dart:async';
import 'package:searching_dataverse/app/globals.dart';
import 'package:searching_dataverse/src/features/home/landing/home_screen.dart';
import 'package:searching_dataverse/src/features/home/search_screen/search_view_screen.dart';
import 'package:searching_dataverse/src/features/splash_screen/splash_screen.dart';

import 'package:searching_dataverse/utils/router/back_button_dispatcher.dart';

import 'package:searching_dataverse/utils/router/ui_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../extensions/extensions.dart' as scaffold_helper;
import 'app_state.dart';

class CasheroRouterDelegate extends RouterDelegate<PageConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  late final AppState appState;

  late AppBackButtonDispatcher backButtonDispatcher;

  CasheroRouterDelegate(this.appState) {
    appState.addListener(() {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Faulty Code will need to find a way to solve it
    appState.globalErrorShow = (value) {
      context.show(message: value);
    };

    return Container(
      key: ValueKey(appState.pages.last.name),
      child: Navigator(
        key: navigatorKeyGlobal,
        onPopPage: _onPopPage,
        pages: buildPages(),
      ),
    );
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        addPage(appState.currentAction.page!);
        break;
      case PageState.pop:
        pop();
        break;
      case PageState.addAll:
        // TODO: Handle this case.
        break;
      case PageState.addWidget:
        break;
      case PageState.replace:
        replace(appState.currentAction.page!);
        break;
      case PageState.replaceAll:
        replaceAll(appState.currentAction.page!);
        break;
    }
    return List.of(appState.pages);
  }

  void replaceAll(PageConfiguration newRoute) {
    appState.pages.clear();
    setNewRoutePath(newRoute);
  }

  void replace(PageConfiguration newRoute) {
    if (appState.pages.isNotEmpty) {
      appState.pages.removeLast();
    }
    addPage(newRoute);
  }

  /// This method adds pages based on the pageconfig received
  /// [Input]: [PageConfiguration]
  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = appState.pages.isEmpty || (appState.pages.last.name != pageConfig.path);

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Splash:
          _addPageData(SplashPage(), pageConfig);
          break;
        case Pages.HomeScreen:
          _addPageData(HomeScreen(), pageConfig);
          break;
        case Pages.SearchViewScreen:
          _addPageData(SearchViewScreen(), pageConfig);
          break;
      }
    }
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    appState.pages.add(
      _createPage(child, pageConfig),
    );
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(child: child, key: ValueKey(pageConfig.key), name: pageConfig.path, arguments: pageConfig);
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void pop() {
    if (canPop()) {
      _removePage(appState.pages.last as MaterialPage);
    }
  }

  void _removePage(MaterialPage page) {
    appState.pages.remove(page);
  }

  bool canPop() {
    return appState.pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(appState.pages.last as MaterialPage);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = appState.pages.isEmpty || (appState.pages.last.name != configuration.path);

    if (!shouldAddPage) {
      return SynchronousFuture(null);
    }
    appState.pages.clear();
    addPage(configuration);

    return SynchronousFuture(null);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigatorKeyGlobal;
}
