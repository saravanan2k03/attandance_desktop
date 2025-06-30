class EmployeeLeaveRequestResponse {
  final String message;
  final int? employeeId;
  final int? available;
  final int? requested;

  EmployeeLeaveRequestResponse({
    required this.message,
    this.employeeId,
    this.available,
    this.requested,
  });

  factory EmployeeLeaveRequestResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveRequestResponse(
      message: json['message'] ?? '',
      employeeId: json['employee_id'],
      available: json['available'],
      requested: json['requested'],
    );
  }
}
