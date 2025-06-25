import 'dart:convert';

class DepartmentupdateModel {
  String? message;
  DepartmentupdateModel({this.message});
  DepartmentupdateModel copyWith({String? message}) {
    return DepartmentupdateModel(message: message ?? this.message);
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  factory DepartmentupdateModel.fromMap(Map<String, dynamic> map) {
    return DepartmentupdateModel(message: map['message']);
  }
  String toJson() => json.encode(toMap());
  factory DepartmentupdateModel.fromJson(String source) =>
      DepartmentupdateModel.fromMap(json.decode(source));
  @override
  String toString() => 'DepartmentupdateModel(message: $message)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepartmentupdateModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
