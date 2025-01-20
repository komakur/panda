import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:panda/router/app_router.dart';
import 'package:panda/services/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
)

/// Configures dependencies before user logged in. It can be HttpClient, SharedPreferences or other services, which are needed globally.
void configureAuthDependencies() {
  getIt
    ..registerSingleton(AppRouter())
    ..initAuthScope();
}

/// Configure dependencies once user logged in. It can be services which requires user info and any other (ChatBloc etc).
void configureUserDependencies() {
  final isRegistered = getIt.isRegistered<EnvironmentFilter>(
    instanceName: kEnvironmentsFilterName,
  );

  if (isRegistered) {
    getIt
      ..unregister<EnvironmentFilter>(instanceName: kEnvironmentsFilterName)
      ..unregister<Set<String>>(instanceName: kEnvironmentsName);

    getIt.init();
  }
}
