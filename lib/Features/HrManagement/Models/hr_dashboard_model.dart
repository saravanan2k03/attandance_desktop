class HRDashboardModel {
  final HRSummary summary;
  final List<EmployeeLeaveToday> employeesOnLeaveToday;
  final MonthlyAttendanceChart monthlyAttendanceChart;

  HRDashboardModel({
    required this.summary,
    required this.employeesOnLeaveToday,
    required this.monthlyAttendanceChart,
  });

  factory HRDashboardModel.fromJson(Map<String, dynamic> json) {
    return HRDashboardModel(
      summary: HRSummary.fromJson(json['summary']),
      employeesOnLeaveToday:
          (json['employees_on_leave_today'] as List)
              .map((e) => EmployeeLeaveToday.fromJson(e))
              .toList(),
      monthlyAttendanceChart: MonthlyAttendanceChart.fromJson(
        json['monthly_attendance_chart'],
      ),
    );
  }
}

class HRSummary {
  final int totalEmployees;
  final int presentToday;
  final int absentToday;
  final int onLeaveToday;
  final int pendingLeaveRequests;
  final int newJoinsThisMonth;
  final int lateCheckinsToday;
  final int activeDevicesLoggedIn;

  HRSummary({
    required this.totalEmployees,
    required this.presentToday,
    required this.absentToday,
    required this.onLeaveToday,
    required this.pendingLeaveRequests,
    required this.newJoinsThisMonth,
    required this.lateCheckinsToday,
    required this.activeDevicesLoggedIn,
  });

  factory HRSummary.fromJson(Map<String, dynamic> json) {
    return HRSummary(
      totalEmployees: json['total_employees'] ?? 0,
      presentToday: json['present_today'] ?? 0,
      absentToday: json['absent_today'] ?? 0,
      onLeaveToday: json['on_leave_today'] ?? 0,
      pendingLeaveRequests: json['pending_leave_requests'] ?? 0,
      newJoinsThisMonth: json['new_joins_this_month'] ?? 0,
      lateCheckinsToday: json['late_checkins_today'] ?? 0,
      activeDevicesLoggedIn: json['active_devices_logged_in'] ?? 0,
    );
  }
}

class EmployeeLeaveToday {
  final int employeeId;
  final String fullName;
  final String department;
  final String designation;
  final String leaveType;
  final String leaveStatus;
  final String leaveRemarks;
  final String leaveDuration;

  EmployeeLeaveToday({
    required this.employeeId,
    required this.fullName,
    required this.department,
    required this.designation,
    required this.leaveType,
    required this.leaveStatus,
    required this.leaveRemarks,
    required this.leaveDuration,
  });

  factory EmployeeLeaveToday.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveToday(
      employeeId: json['employee_id'],
      fullName: json['full_name'],
      department: json['department'],
      designation: json['designation'],
      leaveType: json['leave_type'],
      leaveStatus: json['leave_status'],
      leaveRemarks: json['leave_remarks'],
      leaveDuration: json['leave_duration'],
    );
  }
}

class MonthlyAttendanceChart {
  final List<String> labels;
  final List<int> present;
  final List<int> absent;

  MonthlyAttendanceChart({
    required this.labels,
    required this.present,
    required this.absent,
  });

  factory MonthlyAttendanceChart.fromJson(Map<String, dynamic> json) {
    return MonthlyAttendanceChart(
      labels: List<String>.from(json['labels']),
      present: List<int>.from(json['present']),
      absent: List<int>.from(json['absent']),
    );
  }
}
