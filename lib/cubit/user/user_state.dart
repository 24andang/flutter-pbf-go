part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final List<UserModel> users;

  UserLoaded(this.users);
}

final class UserSuccess extends UserState {
  final String message;

  UserSuccess(this.message);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}
