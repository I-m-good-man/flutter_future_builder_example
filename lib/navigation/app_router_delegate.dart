import 'package:app_navigation_template/pages/FuturePage.dart';
import 'package:app_navigation_template/pages/HomePage.dart';
import 'package:app_navigation_template/pages/LaunchPage.dart';
import 'package:app_navigation_template/pages/UndefinedPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_path.dart';
import 'app_route_config.dart';
import 'package:flutter/material.dart';

class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationProvider _navigationProvider;
  final WidgetRef ref;

  AppRouterDelegate({required this.ref})
      : _navigationProvider = navigationProvider {
    ref.listen(_navigationProvider, (prev, next) {
      notifyListeners();
    });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey {
    return GlobalKey();
  }

  @override
  Future<bool> popRoute() async {
    if (ref.read(_navigationProvider).pageConfig.length > 1) {
      ref.read(_navigationProvider.notifier).popPath();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<MaterialPage> pages = [
      for (AppPath appPath in ref.read(_navigationProvider).pageConfig)
        MaterialPage(child: _mapAppPathToAppPage(appPath: appPath))
    ];
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  Widget _mapAppPathToAppPage({required AppPath appPath}) {
    return switch (appPath.runtimeType) {
      LaunchPath => LaunchPage(),
      HomePath => HomePage(),
      FuturePath => FuturePage(),
      UndefinedPath => UndefinedPage(),
      _ => UndefinedPage()
    };
  }

  @override
  AppRouteConfig get currentConfiguration {
    return ref.read(_navigationProvider);
  }

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    ref.read(_navigationProvider.notifier).setNewState(newState: configuration);
  }

  @override
  Future<void> setInitialRoutePath(AppRouteConfig configuration) async {
    // Ignore first RouteInformation from platform, cause the app has an own
    // initial route configuration.
  }
}
