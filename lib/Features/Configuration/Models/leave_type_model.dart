import 'dart:convert';

class LeaveTypeModel {
  String? message;
  String? leaveType;
  String? organization;
  LeaveTypeModel({this.message, this.leaveType, this.organization});
  LeaveTypeModel copyWith({
    String? message,
    String? leaveType,
    String? organization,
  }) {
    return LeaveTypeModel(
      message: message ?? this.message,
      leaveType: leaveType ?? this.leaveType,
      organization: organization ?? this.organization,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'leaveType': leaveType,
      'organization': organization,
    };
  }

  factory LeaveTypeModel.fromMap(Map<String, dynamic> map) {
    return LeaveTypeModel(
      message: map['message'],
      leaveType: map['leave_type'],
      organization: map['organization'],
    );
  }
  String toJson() => json.encode(toMap());
  factory LeaveTypeModel.fromJson(String source) =>
      LeaveTypeModel.fromMap(json.decode(source));
  @override
  String toString() =>
      'LeaveTypeModel(message: $message, leaveType: $leaveType, organization: $organization)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LeaveTypeModel &&
        other.message == message &&
        other.leaveType == leaveType &&
        other.organization == organization;
  }

  @override
  int get hashCode =>
      message.hashCode ^ leaveType.hashCode ^ organization.hashCode;
}
