import 'package:app_navigation_template/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        wrappedWidget: const Center(
      child: Text('HomePage'),
    ));
  }
}
