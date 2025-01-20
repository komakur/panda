import 'package:auto_route/auto_route.dart';
import 'package:panda/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: AuthRoute.page,
          children: [
            AutoRoute(
              path: 'login',
              page: LoginRoute.page,
            ),
            AutoRoute(
              path: 'home',
              page: HomeRouter.page,
              children: [
                AutoRoute(
                  initial: true,
                  path: '',
                  page: ChatsRoute.page,
                ),
              ],
            ),
          ],
        ),
      ];
}
