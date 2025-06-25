import 'dart:convert';

class DepartmentaddModel {
  String? message;
  int? id;
  DepartmentaddModel({this.message, this.id});
  DepartmentaddModel copyWith({String? message, int? id}) {
    return DepartmentaddModel(
      message: message ?? this.message,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'id': id};
  }

  factory DepartmentaddModel.fromMap(Map<String, dynamic> map) {
    return DepartmentaddModel(message: map['message'], id: map['id']);
  }
  String toJson() => json.encode(toMap());
  factory DepartmentaddModel.fromJson(String source) =>
      DepartmentaddModel.fromMap(json.decode(source));
  @override
  String toString() => 'DepartmentaddModel(message: $message, id: $id)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepartmentaddModel &&
        other.message == message &&
        other.id == id;
  }

  @override
  int get hashCode => message.hashCode ^ id.hashCode;
}
