import 'dart:io';

import 'package:act/Core/Services/encryption_repo.dart';
import 'package:act/Core/Services/hive_services.dart';

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
