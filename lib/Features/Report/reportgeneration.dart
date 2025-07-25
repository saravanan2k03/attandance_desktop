import 'dart:io';
import 'package:act/Core/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class EmployeeReportGenerator {
  Future<Uint8List> loadLogo() async {
    final data = await rootBundle.load(Assets.images.hourlyDotLogocropped.path);
    return data.buffer.asUint8List();
  }

  Future<File> generateEmployeeReport(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final logoBytes = await loadLogo();
    // Extract data from JSON
    final attendanceReports = data['attendance_reports'] as List<dynamic>;
    final salarySheets = data['salary_sheets'] as List<dynamic>;
    final leaveSummary = data['leave_summary'] as List<dynamic>;
    final gosiSummary = data['gosi_summary'] as List<dynamic>;

    // Get employee name
    final employeeName =
        attendanceReports.isNotEmpty
            ? attendanceReports[0]['employee_id__full_name']
            : 'Unknown Employee';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            _buildMinimalistHeader(employeeName, logoBytes),
            pw.SizedBox(height: 40),

            _buildAttendanceCard(attendanceReports),
            pw.SizedBox(height: 32),

            _buildSalaryCard(salarySheets),
            pw.SizedBox(height: 32),

            _buildLeaveCard(leaveSummary),
            pw.SizedBox(height: 32),

            _buildGosiCard(gosiSummary),

            pw.Spacer(),
            _buildMinimalistFooter(),
          ];
        },
      ),
    );

    final output = await getDownloadsDirectory();
    final file = File(
      '${output!.path}/employee_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static pw.Widget _buildMinimalistHeader(
    String employeeName,
    Uint8List bytes,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Image(pw.MemoryImage(bytes), width: 100, height: 150),
        pw.Text(
          'Employee Report',
          style: pw.TextStyle(
            fontSize: 32,
            fontWeight: pw.FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(height: 2, width: 60, color: PdfColors.grey800),
        pw.SizedBox(height: 24),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  employeeName,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Employee ID: EMP001',
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
                ),
              ],
            ),
            pw.Text(
              DateFormat('MMM dd, yyyy').format(DateTime.now()),
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildAttendanceCard(List<dynamic> attendanceReports) {
    return pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Attendance'),
          pw.SizedBox(height: 16),
          if (attendanceReports.isNotEmpty) ...[
            for (var attendance in attendanceReports)
              pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 12),
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: _buildInfoItem('Date', attendance['date'] ?? ''),
                    ),
                    pw.Expanded(
                      child: _buildInfoItem(
                        'Check In',
                        attendance['check_in_time'] ?? '',
                      ),
                    ),
                    pw.Expanded(
                      child: _buildInfoItem(
                        'Check Out',
                        attendance['check_out_time'] ?? '',
                      ),
                    ),
                    pw.Expanded(
                      child: _buildInfoItem(
                        'Hours',
                        '${attendance['work_hours'] ?? 0}h',
                      ),
                    ),
                  ],
                ),
              ),
          ] else
            _buildEmptyState('No attendance records'),
        ],
      ),
    );
  }

  static pw.Widget _buildSalaryCard(List<dynamic> salarySheets) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Salary Details'),
        pw.SizedBox(height: 16),
        if (salarySheets.isNotEmpty) ...[
          for (var salary in salarySheets)
            pw.Container(
              padding: const pw.EdgeInsets.all(24),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        DateFormat(
                          'MMMM yyyy',
                        ).format(DateTime.parse(salary['month'])),
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.green100,
                          borderRadius: pw.BorderRadius.circular(20),
                        ),
                        child: pw.Text(
                          '\$${salary['net_salary']?.toStringAsFixed(2) ?? '0.00'}',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColors.green800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: _buildSalaryItem(
                          'Basic',
                          salary['basic_salary'],
                        ),
                      ),
                      pw.Expanded(
                        child: _buildSalaryItem(
                          'Allowance',
                          salary['allowance'],
                        ),
                      ),
                      pw.Expanded(
                        child: _buildSalaryItem(
                          'Overtime',
                          salary['over_time_salary'],
                        ),
                      ),
                      pw.Expanded(
                        child: _buildSalaryItem(
                          'Deduction',
                          salary['deduction'],
                          isNegative: true,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Container(height: 1, color: PdfColors.grey200),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: _buildAttendanceItem(
                          'Present',
                          salary['present_days'],
                        ),
                      ),
                      pw.Expanded(
                        child: _buildAttendanceItem(
                          'Absent',
                          salary['absent_days'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ] else
          _buildEmptyState('No salary information'),
      ],
    );
  }

  static pw.Widget _buildLeaveCard(List<dynamic> leaveSummary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Leave Summary'),
        pw.SizedBox(height: 16),
        if (leaveSummary.isNotEmpty) ...[
          for (var leave in leaveSummary)
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      color: _getLeaveTypeColor(
                        leave['leave_type__leave_type'],
                      ),
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      leave['leave_type__leave_type'] ?? '',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.white,
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 16),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '${leave['start_date']} - ${leave['end_date']}',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.normal,
                          ),
                        ),
                        pw.Text(
                          '${leave['leave_days']} days • ${leave['status']}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ] else
          _buildEmptyState('No leave records'),
      ],
    );
  }

  static pw.Widget _buildGosiCard(List<dynamic> gosiSummary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('GOSI Information'),
        pw.SizedBox(height: 16),
        if (gosiSummary.isNotEmpty) ...[
          for (var gosi in gosiSummary)
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: _buildInfoItem(
                      'Iqama Number',
                      gosi['iqama_number'] ?? '',
                    ),
                  ),
                  pw.Expanded(
                    child: _buildInfoItem(
                      'Basic Salary',
                      '\$${gosi['basic_salary']?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                  ),
                  pw.Expanded(
                    child: _buildInfoItem(
                      'GOSI Deduction',
                      '\$${gosi['gosi_deduction_amount']?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                  ),
                ],
              ),
            ),
        ] else
          _buildEmptyState('No GOSI information'),
      ],
    );
  }

  static pw.Widget _buildSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 18,
        fontWeight: pw.FontWeight.normal,
        letterSpacing: -0.2,
      ),
    );
  }

  static pw.Widget _buildInfoItem(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey600,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.normal),
        ),
      ],
    );
  }

  static pw.Widget _buildSalaryItem(
    String label,
    dynamic amount, {
    bool isNegative = false,
  }) {
    final value = amount?.toStringAsFixed(2) ?? '0.00';
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          '${isNegative ? '-' : ''}\$$value',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.normal,
            color: isNegative ? PdfColors.red600 : PdfColors.grey800,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildAttendanceItem(String label, dynamic count) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          '${count ?? 0} days',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.normal),
        ),
      ],
    );
  }

  static pw.Widget _buildEmptyState(String message) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(32),
      child: pw.Center(
        child: pw.Text(
          message,
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey500,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
      ),
    );
  }

  static pw.Widget _buildMinimalistFooter() {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 20),
      child: pw.Column(
        children: [
          pw.Container(height: 1, color: PdfColors.grey200),
          pw.SizedBox(height: 16),
          pw.Text(
            'Generated automatically • ${DateFormat('MMM dd, yyyy \'at\' HH:mm').format(DateTime.now())}',
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
          ),
        ],
      ),
    );
  }

  static PdfColor _getLeaveTypeColor(String? leaveType) {
    switch (leaveType?.toUpperCase()) {
      case 'SICK':
        return PdfColors.red400;
      case 'ANNUAL':
        return PdfColors.blue400;
      case 'PERSONAL':
        return PdfColors.purple400;
      case 'EMERGENCY':
        return PdfColors.orange400;
      default:
        return PdfColors.grey400;
    }
  }
}

// Usage example
// class EmployeeReportService {
//   static Future<void> generateAndSaveReport(
//     Map<String, dynamic> jsonData,
//   ) async {
//     try {
//       final file = await EmployeeReportGenerator.generateEmployeeReport(
//         jsonData,
//       );
//       debugPrint(' Beautiful PDF generated at: ${file.path}');

//       // You can also share or open the PDF file here
//       // For example, using the share_plus package:
//       // await Share.shareXFiles([XFile(file.path)]);
//     } catch (e) {
//       debugPrint(' Error generating PDF: $e');
//     }
//   }
// }

// Sample usage in your widget

// void generateBeautifulReport() async {
//   final jsonData = {
//     "attendance_reports": [
//       {
//         "employee_id__full_name": "John Doe",
//         "date": "2025-06-25",
//         "present_one": "Present",
//         "present_two": "Present",
//         "check_in_time": "09:00:00",
//         "check_out_time": "18:00:00",
//         "work_hours": 8.0,
//         "is_overtime": false,
//         "overtime_hours": 0,
//       },
//     ],
//     "salary_sheets": [
//       {
//         "employee_id__full_name": "John Doe",
//         "month": "2025-06-01",
//         "basic_salary": 3000.0,
//         "allowance": 500.0,
//         "deduction": 200.0,
//         "net_salary": 3300.0,
//         "present_days": 26,
//         "absent_days": 2,
//         "over_time_salary": 150.0,
//       },
//     ],
//     "leave_summary": [
//       {
//         "employee_id__full_name": "John Doe",
//         "leave_type__leave_type": "SICK",
//         "start_date": "2025-06-15",
//         "end_date": "2025-06-17",
//         "leave_days": 3,
//         "status": "Approved",
//         "remarks": "Flu",
//       },
//     ],
//     "gosi_summary": [
//       {
//         "full_name": "John Doe",
//         "iqama_number": "123456789",
//         "basic_salary": 3000.0,
//         "gosi_deduction_amount": 270.0,
//       },
//     ],
//   };

//   await EmployeeReportService.generateAndSaveReport(jsonData);
// }
