import 'package:app_navigation_template/navigation/app_route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_path.dart';

class ScaffoldWrapper extends ConsumerWidget {
  ScaffoldWrapper({required this.wrappedWidget, super.key})
      : _navigationProvider = navigationProvider;

  final Widget wrappedWidget;
  final NavigationProvider _navigationProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(_navigationProvider).pageConfig.last.toString()),
        actions: [
          IconButton(
              onPressed: () {
                AppRouteConfig state = ref.read(_navigationProvider);
                List<AppPath> pageConfig = state.pageConfig;

                AppRouteConfig newState = state.copyWith(
                    pageConfig: pageConfig
                      ..add(switch (pageConfig.last.runtimeType) {
                        LaunchPath => HomePath(),
                        HomePath => FuturePath(),
                        FuturePath => LaunchPath(),
                        _ => throw Exception('Foreign AppPath')
                      }));

                ref
                    .read(_navigationProvider.notifier)
                    .setNewState(newState: newState);
              },
              icon: const Icon(Icons.navigate_next))
        ],
      ),
      body: wrappedWidget,
    );
  }
}
