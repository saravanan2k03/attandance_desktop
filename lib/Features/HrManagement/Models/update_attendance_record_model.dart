import 'dart:convert';

class UpdateAttendanceRecordModel {
  String? message;
  UpdateAttendanceRecordModel({this.message});
  UpdateAttendanceRecordModel copyWith({String? message}) {
    return UpdateAttendanceRecordModel(message: message ?? this.message);
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  factory UpdateAttendanceRecordModel.fromMap(Map<String, dynamic> map) {
    return UpdateAttendanceRecordModel(message: map['message']);
  }
  String toJson() => json.encode(toMap());
  factory UpdateAttendanceRecordModel.fromJson(String source) =>
      UpdateAttendanceRecordModel.fromMap(json.decode(source));
  @override
  String toString() => 'UpdateAttendanceRecordModel(message: $message)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateAttendanceRecordModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
