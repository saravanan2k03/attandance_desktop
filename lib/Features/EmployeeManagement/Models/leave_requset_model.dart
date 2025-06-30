import 'dart:convert';

class LeaveRequestResponse {
  final List<LeaveRequest> leaveRequests;

  LeaveRequestResponse({required this.leaveRequests});

  factory LeaveRequestResponse.fromJson(String str) =>
      LeaveRequestResponse.fromMap(jsonDecode(str));

  factory LeaveRequestResponse.fromMap(Map<String, dynamic> json) =>
      LeaveRequestResponse(
        leaveRequests: List<LeaveRequest>.from(
          (json["leave_requests"] ?? []).map((x) => LeaveRequest.fromMap(x)),
        ),
      );
}

class LeaveRequest {
  final int id;
  final String employeeName;
  final String leaveType;
  final String startDate;
  final String endDate;
  final int leaveDays;
  final String? status;
  final String? remarks;

  LeaveRequest({
    required this.id,
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.leaveDays,
    this.status,
    this.remarks,
  });

  factory LeaveRequest.fromMap(Map<String, dynamic> json) => LeaveRequest(
    id: json["id"],
    employeeName: json["employee_name"],
    leaveType: json["leave_type"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    leaveDays: json["leave_days"],
    status: json["status"],
    remarks: json["remarks"],
  );
}
