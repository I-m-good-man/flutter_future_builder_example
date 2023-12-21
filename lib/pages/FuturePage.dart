import 'package:app_navigation_template/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuturePage extends ConsumerStatefulWidget {
  const FuturePage({super.key});

  @override
  ConsumerState createState() {
    return FuturePageState();
  }
}

class FuturePageState extends ConsumerState<FuturePage> {
  late final Future<String> name;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: name,
        initialData: 'nobody',
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String text = switch (snapshot.connectionState) {
            ConnectionState.waiting => 'waiting ${snapshot.data}',
            ConnectionState.none => 'none ${snapshot.data}',
            ConnectionState.done => 'done ${snapshot.data}',
            ConnectionState.active => 'error ${snapshot.data}'
          };

          return ScaffoldWrapper(
              wrappedWidget: Center(
            child: Text(text),
          ));
        });
  }

  @override
  void initState() {
    super.initState();
    name = getName();
  }
}

Future<String> getName() async {
  return Future<String>.delayed(const Duration(seconds: 5), () => 'Marat');
}
