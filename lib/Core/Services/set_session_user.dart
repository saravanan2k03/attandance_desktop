import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/Auth/Data/Models/login_model.dart';

Future<void> setUserSessionFromLoginModel(LoginModel loginModel) async {
  final session = SessionManagerClass();

  try {
    final accessToken = loginModel.tokens?.access ?? "";
    final refreshToken = loginModel.tokens?.refresh ?? "";
    final userId = loginModel.user?.id?.toString() ?? "";
    final username = loginModel.user?.username ?? "";
    final email = loginModel.user?.email ?? "";
    final userType = loginModel.user?.userType ?? "";

    await session.setAccessToken(accessToken);
    await session.setRefreshToken(refreshToken);
    await session.setuserid(userId);
    await session.setusername(username);
    await session.setemail(email);
    await session.setusertype(userType);
  } catch (e) {
    throw Exception("Failed to set session data from LoginModel: $e");
  }
}

Future<bool> isSessionValid() async {
  final session = SessionManagerClass();

  final accessToken = await session.getAccessToken();
  final refreshToken = await session.getRefreshToken();
  final userId = await session.getuserid();
  final username = await session.getusername();
  final email = await session.getemail();
  final userType = await session.getusertype();

  if (accessToken.isNotEmpty &&
      refreshToken.isNotEmpty &&
      userId.isNotEmpty &&
      username.isNotEmpty &&
      email.isNotEmpty &&
      userType.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
