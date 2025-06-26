import 'dart:convert';

class EmployeeLeaveDetailModel {
  final int id;
  final int leaveCount;
  final String leaveType;

  EmployeeLeaveDetailModel({
    required this.id,
    required this.leaveCount,
    required this.leaveType,
  });

  factory EmployeeLeaveDetailModel.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveDetailModel(
      id: json['id'],
      leaveCount: json['leave_count'],
      leaveType: json['employee_leave_type']['leave_type'],
    );
  }

  static List<EmployeeLeaveDetailModel> listFromJson(String body) {
    final List<dynamic> jsonData = jsonDecode(body);
    return jsonData.map((e) => EmployeeLeaveDetailModel.fromJson(e)).toList();
  }
}
