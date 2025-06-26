part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginDataEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginDataEvent({required this.username, required this.password});
}
