import 'dart:async';
import 'dart:developer';
import 'package:act/Core/Services/hive_services.dart';
import 'package:act/Core/Services/session_manager.dart';
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
    on<LogOutEvent>(logoutevent);
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
        emit(
          LoginSuccessState(
            loginData.user!.id ?? 0,
            userType: loginData.user?.userType ?? "employee",
          ),
        );
      } else {
        emit(LoginError());
      }
    } catch (e) {
      emit(LoginError());
    }
  }

  FutureOr<void> logoutevent(
    LogOutEvent event,
    Emitter<LoginState> emit,
  ) async {
    final AuthRepo authrepo = AuthRepo();
    final HiveServices hiveServices = HiveServices();
    final session = SessionManagerClass();
    await session.getlicence().then((value){
      log(value);
    });
    authrepo.logoutapi().whenComplete(() {
      hiveServices.deleteAllExceptLicenceKey().then((value) {
        emit(LogoutSucess());
      });
    });
    
    try {} catch (e) {
      emit(LogoutError());
    }
  }
}
