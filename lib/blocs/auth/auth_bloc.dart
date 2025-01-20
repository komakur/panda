import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:panda/models/user_profile/user_profile.dart';
import 'package:panda/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

/// Global AuthBloc. Uses AuthRepository. Usually it would use Stream from AuthRepository of user auth changes.
@Singleton(scope: 'auth')
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(
    this._authRepository,
  ) : super(const AuthState()) {
    on<_SignInWithUsername>(_onSignInWithEmailAndPassword);
  }

  void signInWithUsername(String username) =>
      add(_SignInWithUsername(username));

  Future<void> _onSignInWithEmailAndPassword(
    _SignInWithUsername event,
    Emitter<AuthState> emit,
  ) async {
    final userProfile =
        await _authRepository.signInWithUsername(event.username);
    try {
      emit(AuthState.authenticated(userProfile));
    } catch (e, stackTrace) {
      addError(e, stackTrace);

      emit(AuthState.unauthenticated());
    }
  }
}

enum AuthStatus {
  initial,
  unauthenticated,
  authenticated;

  bool get isInitial => this == initial;
  bool get isUnAuthenticated => this == unauthenticated;
  bool get isAuthenticated => this == authenticated;
}
