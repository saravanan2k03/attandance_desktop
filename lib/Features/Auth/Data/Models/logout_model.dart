import 'dart:convert';

class LogoutModel {
  String? message;
  bool? status;
  LogoutModel({this.message, this.status});
  LogoutModel copyWith({String? message, bool? status}) {
    return LogoutModel(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'status': status};
  }

  factory LogoutModel.fromMap(Map<String, dynamic> map) {
    return LogoutModel(message: map['message'], status: map['status']);
  }
  String toJson() => json.encode(toMap());
  factory LogoutModel.fromJson(String source) =>
      LogoutModel.fromMap(json.decode(source));
  @override
  String toString() => 'LogoutModel(message: $message, status: $status)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogoutModel &&
        other.message == message &&
        other.status == status;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode;
}
