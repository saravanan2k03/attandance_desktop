import 'dart:convert';

class ConfigAddOrUpdateModel {
  String? message;
  ConfigAddOrUpdateModel({this.message});
  ConfigAddOrUpdateModel copyWith({String? message}) {
    return ConfigAddOrUpdateModel(message: message ?? this.message);
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  factory ConfigAddOrUpdateModel.fromMap(Map<String, dynamic> map) {
    return ConfigAddOrUpdateModel(message: map['message']);
  }
  String toJson() => json.encode(toMap());
  factory ConfigAddOrUpdateModel.fromJson(String source) =>
      ConfigAddOrUpdateModel.fromMap(json.decode(source));
  @override
  String toString() => 'ConfigAddOrUpdateModel(message: $message)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigAddOrUpdateModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
