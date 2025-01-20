import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:panda/services/injectable.dart';

@RoutePage(name: 'HomeRouter')
class HomeWrapperScreen extends StatefulWidget {
  const HomeWrapperScreen({super.key});

  @override
  State<HomeWrapperScreen> createState() => _HomeWrapperScreenState();
}

class _HomeWrapperScreenState extends State<HomeWrapperScreen> {
  @override
  void initState() {
    super.initState();

    getIt.pushNewScope(
      init: (_) => configureUserDependencies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
