import 'dart:io';
import 'package:act/Core/Services/encryption_repo.dart';
import 'package:act/Core/Services/hive_services.dart';

class SessionManagerClass {
  final HiveServices localdb = HiveServices();

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

  Future<void> setlicence(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setRefreshToken::encryption::$enc");
      await localdb.createData('licencekey', enc);
    } on Exception catch (e) {
      throw HttpException(
        "Error In setlicencekey:::${e.toString()}",
      ).toString();
    }
  }

  Future<String> getlicence() async {
    try {
      var raw = await localdb.readData('licencekey');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException(
        "Error In getlicencekey:::${e.toString()}",
      ).toString();
    }
  }

  Future<void> setuserid(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setRefreshToken::encryption::$enc");
      await localdb.createData('userid', enc);
    } on Exception catch (e) {
      throw HttpException("Error In setuserid:::${e.toString()}").toString();
    }
  }

  Future<void> setusername(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setRefreshToken::encryption::$enc");
      await localdb.createData('username', enc);
    } on Exception catch (e) {
      throw HttpException("Error In username:::${e.toString()}").toString();
    }
  }

  Future<void> setemail(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setRefreshToken::encryption::$enc");
      await localdb.createData('email', enc);
    } on Exception catch (e) {
      throw HttpException("Error In setemail:::${e.toString()}").toString();
    }
  }

  Future<void> setusertype(String token) async {
    try {
      var enc = EncryptionRepo.encryptData(token);
      // log("setRefreshToken::encryption::$enc");
      await localdb.createData('user_type', enc);
    } on Exception catch (e) {
      throw HttpException("Error In setusertype:::${e.toString()}").toString();
    }
  }

  Future<String> getuserid() async {
    try {
      var raw = await localdb.readData('userid');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException("Error In getuserid:::${e.toString()}").toString();
    }
  }

  Future<String> getusername() async {
    try {
      var raw = await localdb.readData('username');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException("Error In getusername:::${e.toString()}").toString();
    }
  }

  Future<String> getemail() async {
    try {
      var raw = await localdb.readData('email');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException("Error In getemail:::${e.toString()}").toString();
    }
  }

  Future<String> getusertype() async {
    try {
      var raw = await localdb.readData('user_type');
      if (raw != null) {
        var dec = EncryptionRepo.decryptData(raw);
        return dec;
      } else {
        return "";
      }
    } on Exception catch (e) {
      throw HttpException("Error In getusertype:::${e.toString()}").toString();
    }
  }

  
}
