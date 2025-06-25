import 'dart:convert';

class DesignationaddModel {
  String? message;
  int? id;
  DesignationaddModel({this.message, this.id});
  DesignationaddModel copyWith({String? message, int? id}) {
    return DesignationaddModel(
      message: message ?? this.message,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'id': id};
  }

  factory DesignationaddModel.fromMap(Map<String, dynamic> map) {
    return DesignationaddModel(message: map['message'], id: map['id']);
  }
  String toJson() => json.encode(toMap());
  factory DesignationaddModel.fromJson(String source) =>
      DesignationaddModel.fromMap(json.decode(source));
  @override
  String toString() => 'DesignationaddModel(message: $message, id: $id)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DesignationaddModel &&
        other.message == message &&
        other.id == id;
  }

  @override
  int get hashCode => message.hashCode ^ id.hashCode;
}
