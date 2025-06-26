import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = dotenv.get('baseUrl', fallback: 'null');
  static String refreshToken = "auth/token/refresh/";
  static String login = "auth/login/";
  static String logout = "auth/logout/";
  static String forgotapi = "auth/forgot-password/";
  static String adddepartments = "departments/add/";
  static String updatedepartment = "departments/update/";
  static String listdepartment = "departments/";
  static String listdesignation = "designations/";
  static String updatedesination = "designations/update/";
  static String adddesignation = "designations/add/";
}
