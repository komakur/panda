import 'package:flutter/material.dart';
import 'package:panda/app/app_state_wrapper.dart';
import 'package:panda/router/app_router.dart';
import 'package:panda/services/injectable.dart';

class PandaApp extends StatelessWidget {
  const PandaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp.router(
        routerConfig: getIt<AppRouter>().config(),
      ),
    );
  }
}
