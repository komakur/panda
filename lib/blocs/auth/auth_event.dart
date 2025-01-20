part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authenticationStatusChanged(
    AuthStatus status,
  ) = _AuthenticationStatusChanged;
  const factory AuthEvent.signWithInUsername(
    String username,
  ) = _SignInWithUsername;
  const factory AuthEvent.signOut() = _SignOut;
}
