import 'dart:convert';

class LeaveRequestFilterModel {
  final List<LeaveRequest> leaveRequests;

  LeaveRequestFilterModel({required this.leaveRequests});

  factory LeaveRequestFilterModel.fromJson(String source) {
    final jsonData = jsonDecode(source);
    final list = jsonData['leave_requests'] as List<dynamic>? ?? [];
    return LeaveRequestFilterModel(
      leaveRequests: list.map((e) => LeaveRequest.fromMap(e)).toList(),
    );
  }
}

class LeaveRequest {
  final int id;
  final String employeeName;
  final String leaveType;
  final String startDate;
  final String endDate;
  final int leaveDays;
  final String status;
  final String remarks;

  LeaveRequest({
    required this.id,
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.leaveDays,
    required this.status,
    required this.remarks,
  });

  factory LeaveRequest.fromMap(Map<String, dynamic> map) {
    return LeaveRequest(
      id: map['id'],
      employeeName: map['employee_name'] ?? '',
      leaveType: map['leave_type'] ?? '',
      startDate: map['start_date'] ?? '',
      endDate: map['end_date'] ?? '',
      leaveDays: map['leave_days'] ?? 0,
      status: map['status'] ?? '',
      remarks: map['remarks'] ?? '',
    );
  }
}
