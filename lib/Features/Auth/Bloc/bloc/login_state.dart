part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginError extends LoginState {}

class LoginSuccessState extends LoginState {
  final String userType;
  final int userId;

  const LoginSuccessState(this.userId, {required this.userType});
}

class LogoutSucess extends LoginState {}

class LogoutError extends LoginState {}
