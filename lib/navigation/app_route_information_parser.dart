import 'package:app_navigation_template/navigation/app_path.dart';
import 'package:flutter/material.dart';

import 'app_route_config.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRouteConfig> {
  @override
  Future<AppRouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async{
    Uri uri = routeInformation.uri;

    List<AppPath> pageConfig = [
      for (String pathSegment in uri.pathSegments)
        _mapPathSegmentToAppPath(pathSegment: pathSegment)
    ];

    AppRouteConfig appRouteConfig = AppRouteConfig(pageConfig: pageConfig);
    return appRouteConfig;
  }

  AppPath _mapPathSegmentToAppPath({required String pathSegment}) {
    return switch (pathSegment) {
      'launch-path' => LaunchPath(),
      'home-path' => HomePath(),
      'future-path' => FuturePath(),
      'undefined-path' => UndefinedPath(),
      _ => UndefinedPath()
    };
  }

  @override
  RouteInformation restoreRouteInformation(AppRouteConfig configuration) {
    List<String> pathSegments = [
      for (AppPath appPath in configuration.pageConfig)
        _mapAppPathToPathSegment(appPath: appPath)
    ];

    Uri uri = Uri(pathSegments: pathSegments);
    RouteInformation routeInformation = RouteInformation(uri: uri);
    return routeInformation;
  }

  String _mapAppPathToPathSegment({required AppPath appPath}) {
    return switch (appPath.runtimeType) {
      LaunchPath => 'launch-path',
      HomePath => 'home-path',
      FuturePath => 'future-path',
      UndefinedPath => 'undefined-path',
      _ => 'undefined-path'
    };
  }
}
