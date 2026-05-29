part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLogin extends AuthState {
  final UserModel loginuser;

  AuthLogin(this.loginuser);
}

final class AuthLogout extends AuthState {
  final String message;

  AuthLogout(this.message);
}

final class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
