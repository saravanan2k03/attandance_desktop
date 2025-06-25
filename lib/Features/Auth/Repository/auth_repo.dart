import 'dart:developer';

import 'package:act/Core/Services/api_network_services.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/Auth/Data/Models/login_model.dart';
import 'package:act/Features/Auth/Data/Models/logout_model.dart';

class AuthRepo {
  Future<LoginModel> loginapi(String username, String password) async {
    ///Url//
    String loginrepoUrl = "${ApiConstants.baseUrl}${ApiConstants.login}";
    final url = Uri.parse(loginrepoUrl);
    return loginApiData(url, {
      "username": username,
      "password": password,
    }, (json) => LoginModel.fromJson(json));
  }

  Future<LogoutModel> logoutapi() async {
    ///Url//
    String logoutrepoUrl = "${ApiConstants.baseUrl}${ApiConstants.logout}";
    final session = SessionManagerClass();
    var token = await session.getRefreshToken();
    log(token);
    final url = Uri.parse(logoutrepoUrl);
    return postApiWithoutbearer(url, {
      "refresh": token,
    }, (json) => LogoutModel.fromJson(json));
  }

  Future<void> forgotapi() async {
    ///Url//
    String logoutrepoUrl = "${ApiConstants.baseUrl}${ApiConstants.forgotapi}";
    final session = SessionManagerClass();
    var token = await session.getRefreshToken();
    log(token);
    final url = Uri.parse(logoutrepoUrl);
    return postApiWithoutbearer(url, {
      "email": "saravanan2k@gmail.com",
    }, (json) => log(json));
  }
}
