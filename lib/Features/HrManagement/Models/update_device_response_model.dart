import 'dart:convert';

class DevicelupdateModel {
  String? message;
  DevicelupdateModel({this.message});
  DevicelupdateModel copyWith({String? message}) {
    return DevicelupdateModel(message: message ?? this.message);
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  factory DevicelupdateModel.fromMap(Map<String, dynamic> map) {
    return DevicelupdateModel(message: map['message']);
  }
  String toJson() => json.encode(toMap());
  factory DevicelupdateModel.fromJson(String source) =>
      DevicelupdateModel.fromMap(json.decode(source));
  @override
  String toString() => 'DevicelupdateModel(message: $message)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DevicelupdateModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
