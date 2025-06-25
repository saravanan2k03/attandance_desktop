import 'dart:convert';

class DesignationupdateModel {
  String? message;
  DesignationupdateModel({this.message});
  DesignationupdateModel copyWith({String? message}) {
    return DesignationupdateModel(message: message ?? this.message);
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  factory DesignationupdateModel.fromMap(Map<String, dynamic> map) {
    return DesignationupdateModel(message: map['message']);
  }
  String toJson() => json.encode(toMap());
  factory DesignationupdateModel.fromJson(String source) =>
      DesignationupdateModel.fromMap(json.decode(source));
  @override
  String toString() => 'DesignationupdateModel(message: $message)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DesignationupdateModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
