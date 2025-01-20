import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda/blocs/auth/auth_bloc.dart';
import 'package:panda/router/app_router.gr.dart';

/// Uses [AutoRouter].declarative to dynamically build routes based on [AuthState]
@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AutoRouter.declarative(
          routes: (_) {
            return switch (state.status) {
              AuthStatus.initial || AuthStatus.unauthenticated => [
                  const LoginRoute(),
                ],
              AuthStatus.authenticated => [
                  const HomeRouter(),
                ],
            };
          },
        );
      },
    );
  }
}
