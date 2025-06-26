import 'dart:async';

import 'package:act/Core/Services/set_session_user.dart';
import 'package:act/Features/Auth/Data/Models/login_model.dart';
import 'package:act/Features/Auth/Repository/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginDataEvent>(loginevent);
  }

  FutureOr<void> loginevent(
    LoginDataEvent event,
    Emitter<LoginState> emit,
  ) async {
    final AuthRepo authrepo = AuthRepo();
    emit(LoginLoadingState());

    try {
      LoginModel loginData = await authrepo.loginapi(
        event.username,
        event.password,
      );

      if (loginData.tokens != null && loginData.user != null) {
        setUserSessionFromLoginModel(loginData);
        emit(LoginSuccessState());
      } else {
        emit(LoginError());
      }
    } catch (e) {
      emit(LoginError());
    }
  }
}
