class PayrollGenerateResponseModel {
  final String status;
  final String organization;
  final List<PayrollEmployeeSummary> payroll;

  PayrollGenerateResponseModel({
    required this.status,
    required this.organization,
    required this.payroll,
  });

  factory PayrollGenerateResponseModel.fromJson(Map<String, dynamic> json) {
    return PayrollGenerateResponseModel(
      status: json["status"] ?? '',
      organization: json["organization"] ?? '',
      payroll:
          (json["payroll"] as List<dynamic>? ?? [])
              .map((e) => PayrollEmployeeSummary.fromJson(e))
              .toList(),
    );
  }
}

class PayrollEmployeeSummary {
  final int employeeId;
  final String name;
  final double netSalary;
  final String payrollStatus;

  PayrollEmployeeSummary({
    required this.employeeId,
    required this.name,
    required this.netSalary,
    required this.payrollStatus,
  });

  factory PayrollEmployeeSummary.fromJson(Map<String, dynamic> json) {
    return PayrollEmployeeSummary(
      employeeId: json["employee_id"] ?? 0,
      name: json["name"] ?? '',
      netSalary: (json["net_salary"] ?? 0).toDouble(),
      payrollStatus: json["payroll_status"] ?? '',
    );
  }
}
