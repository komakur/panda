import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda/blocs/auth/auth_bloc.dart';

/// LoginScreen. Ideally it should use blocs to validate forms. However, in this case, I just use TextEditingController.
@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameTextFieldController,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  if (_usernameTextFieldController.text.isEmpty) {
                    return;
                  }

                  context
                      .read<AuthBloc>()
                      .signInWithUsername(_usernameTextFieldController.text);
                },
                child: const Text('Log in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
