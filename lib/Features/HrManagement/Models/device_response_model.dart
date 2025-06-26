// device_response_model.dart
import 'dart:convert';

class DeviceResponseModel {
  final String message;
  final Map<String, dynamic>? data;

  DeviceResponseModel({required this.message, this.data});

  factory DeviceResponseModel.fromJson(String source) {
    final json = jsonDecode(source);
    return DeviceResponseModel(
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
