import 'dart:io';

import 'package:act/Core/Services/encryption_repo.dart';
import 'package:act/Core/Services/hive_services.dart';

class SessionManagerClass {
  final HiveServices localdb = HiveServices();
  Future<String> getEmpowerUsername() async {
    try {
      var raw = await localdb.readData('empower_username');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException("Error In getEmpowerUsername:::${(e.toString())}");
    }
  }

  Future<void> setAccessToken(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setAccessToken::encryption::$enc");
      await localdb.createData('access_token', enc);
    } on Exception catch (e) {
      throw HttpException(
        "Error In setAccessToken:::${e.toString()}",
      ).toString();
    }
  }

  Future<String> getAccessToken() async {
    try {
      var raw = await localdb.readData('access_token');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        // log("dec::$dec");
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException(
        "Error In getAccessToken:::${e.toString()}",
      ).toString();
    }
  }

  Future<void> setRefreshToken(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setRefreshToken::encryption::$enc");
      await localdb.createData('refresh_token', enc);
    } on Exception catch (e) {
      throw HttpException(
        "Error In setRefreshToken:::${e.toString()}",
      ).toString();
    }
  }

  Future<String> getRefreshToken() async {
    try {
      var raw = await localdb.readData('refresh_token');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException(
        "Error In getRefreshToken:::${e.toString()}",
      ).toString();
    }
  }
}
