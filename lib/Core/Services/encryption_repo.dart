import 'dart:convert';
import 'dart:math' show Random;
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptionRepo {
  //This is for encryption
  static String encryptData(String data) {
    final keys = encrypt.Key.fromBase64(dotenv.get('BasKey', fallback: ''));
    final iv = encrypt.IV.fromBase64(dotenv.get('IvKey', fallback: ''));
    final cypher = encrypt.Encrypter(
      encrypt.AES(keys, mode: encrypt.AESMode.cbc),
    );
    final encrypted = cypher.encrypt(data, iv: iv);

    return encrypted.base64;
  }

  //This is for decryption
  static String decryptData(String data) {
    final keys = encrypt.Key.fromBase64(dotenv.get('BasKey', fallback: ''));
    final iv = encrypt.IV.fromBase64(dotenv.get('IvKey', fallback: ''));
    final cypher = encrypt.Encrypter(
      encrypt.AES(keys, mode: encrypt.AESMode.cbc),
    );
    final encrypted = encrypt.Encrypted.fromBase64(data);
    final decrypted = cypher.decrypt(encrypted, iv: iv);
    return decrypted;
  }

  static String generateBaseKey64() {
    final random = Random.secure();
    final key = Uint8List(32);
    for (var i = 0; i < key.length; i++) {
      key[i] = random.nextInt(256);
    }

    return base64Encode(key);
  }

  static String generateIVKey64() {
    final random = Random.secure();
    final iv = Uint8List(16);
    for (var i = 0; i < iv.length; i++) {
      iv[i] = random.nextInt(256);
    }

    return base64Encode(iv);
  }
}
