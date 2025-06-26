class EmployeeDashboardModel {
  final String employeeName;
  final int attendanceThisMonth;
  final int leavesTaken;
  final int lateLogins;
  final int absentInThisMonth;
  final double overtimeWorking;
  final int pendingLeaveRequests;
  final String punchIn;
  final String punchOut;
  final List<AttendanceTableData> tableData;
  final PieChartData pieChart;

  EmployeeDashboardModel({
    required this.employeeName,
    required this.attendanceThisMonth,
    required this.leavesTaken,
    required this.lateLogins,
    required this.absentInThisMonth,
    required this.overtimeWorking,
    required this.pendingLeaveRequests,
    required this.punchIn,
    required this.punchOut,
    required this.tableData,
    required this.pieChart,
  });

  factory EmployeeDashboardModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDashboardModel(
      employeeName: json['employee_name'] ?? '',
      attendanceThisMonth: json['attendance_this_month'] ?? 0,
      leavesTaken: json['leaves_taken'] ?? 0,
      lateLogins: json['late_logins'] ?? 0,
      absentInThisMonth: json['absent_in_this_month'] ?? 0,
      overtimeWorking: (json['overtime_working'] ?? 0).toDouble(),
      pendingLeaveRequests: json['pending_leave_requests'] ?? 0,
      punchIn: json['punch_in'] ?? "00:00",
      punchOut: json['punch_out'] ?? "00:00",
      tableData:
          (json['table_data'] as List)
              .map((e) => AttendanceTableData.fromJson(e))
              .toList(),
      pieChart: PieChartData.fromJson(json['pie_chart']),
    );
  }
}

class AttendanceTableData {
  final String date;
  final String punchIn;
  final String punchOut;

  AttendanceTableData({
    required this.date,
    required this.punchIn,
    required this.punchOut,
  });

  factory AttendanceTableData.fromJson(Map<String, dynamic> json) {
    return AttendanceTableData(
      date: json['date'],
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
    );
  }
}

class PieChartData {
  final double present;
  final double absent;
  final double leave;

  PieChartData({
    required this.present,
    required this.absent,
    required this.leave,
  });

  factory PieChartData.fromJson(Map<String, dynamic> json) {
    return PieChartData(
      present: (json['present'] ?? 0).toDouble(),
      absent: (json['absent'] ?? 0).toDouble(),
      leave: (json['leave'] ?? 0).toDouble(),
    );
  }
}
