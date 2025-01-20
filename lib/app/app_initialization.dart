import 'package:flutter/widgets.dart';
import 'package:panda/services/injectable.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureAuthDependencies();
}
