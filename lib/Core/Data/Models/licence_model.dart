import 'dart:convert';

class LicenseStatusModel {
  final bool activated;

  LicenseStatusModel({required this.activated});

  factory LicenseStatusModel.fromJson(String jsonStr) {
    final json = jsonDecode(jsonStr);
    return LicenseStatusModel(activated: json['activated'] ?? false);
  }
}
