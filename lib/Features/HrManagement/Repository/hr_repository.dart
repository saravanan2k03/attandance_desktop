import 'dart:convert';
import 'dart:developer';

import 'package:act/Core/Services/api_network_services.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/EmployeeManagement/Models/base_response.dart';
import 'package:act/Features/HrManagement/Models/attendance_list_model.dart';
import 'package:act/Features/HrManagement/Models/device_list_model.dart';
import 'package:act/Features/HrManagement/Models/hr_dashboard_model.dart';
import 'package:act/Features/HrManagement/Models/leave_request_filter_model.dart';
import 'package:act/Features/HrManagement/Models/payroll_generated_model.dart';
import 'package:act/Features/HrManagement/Models/payroll_list_model.dart';
import 'package:act/Features/HrManagement/Models/update_device_response_model.dart';

class HrRepository {
  // Future<DeviceResponseModel> addDevice({
  //   required String licenseKey,
  //   required String deviceName,
  //   required String deviceIp,
  //   required String devicePort,
  //   required String syncInterval,
  //   required String lastSyncInterval,
  //   required bool isActive,
  // }) async {
  //   final Uri url = Uri.parse("${ApiConstants.baseUrl}devices/add/");

  //   final Map<String, dynamic> body = {
  //     "license_key": licenseKey,
  //     "device_name": deviceName,
  //     "device_ip": deviceIp,
  //     "device_port": devicePort,
  //     "sync_interval": syncInterval,
  //     "last_sync_interval": lastSyncInterval,
  //     "is_active": isActive,
  //   };

  //   return postApiData<DeviceResponseModel>(
  //     url,
  //     body,
  //     (responseBody) => DeviceResponseModel.fromJson(responseBody),
  //   );
  // }

  Future<BaseResponseModel> addOrUpdateDevice({
    required String licenseKey,
    int? deviceId, // optional for update
    required String deviceName,
    required String deviceIp,
    String? lastSyncInterval, // optional
  }) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}devices/add-or-update/");

    Map<String, String?> body = {
      "license_key": licenseKey,
      "device_name": deviceName,
      "device_ip": deviceIp,
      "last_sync_interval": lastSyncInterval,
    };

    if (deviceId != null) {
      body["device_id"] = deviceId.toString();
    }

    // Remove nulls
    body.removeWhere((key, value) => value == null);

    return await postApiData<BaseResponseModel>(
      uri,
      body,
      BaseResponseModel.fromJson,
    );
  }

  Future<DeviceListModel> listDevices(String licenseKey) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}devices/list/?license_key=$licenseKey",
    );

    return fetchApiData(url, (json) => DeviceListModel.fromJson(json));
  }

  Future<DevicelupdateModel> updateDevice({
    required int id,
    required String licenseKey,
    required String deviceName,
    required String deviceIp,
    required String devicePort,
    required String syncInterval,
    required String lastSyncInterval,
    required bool isActive,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}devices/update/$id/");

    final body = {
      "license_key": licenseKey,
      "device_name": deviceName,
      "device_ip": deviceIp,
      "device_port": devicePort,
      "sync_interval": syncInterval,
      "last_sync_interval": lastSyncInterval,
      "is_active": isActive,
    };

    return patchApiData(url, body, (json) => DevicelupdateModel.fromJson(json));
  }

  Future<AttendanceListModel> fetchAttendanceList({
    String? fromDate,
    String? toDate,
    String? departmentId,
    String? workShift,
    String? licenseKey,
  }) async {
    final queryParameters = <String, String>{};

    if (fromDate != null) queryParameters["from_date"] = fromDate;
    if (toDate != null) queryParameters["to_date"] = toDate;
    if (departmentId != null) queryParameters["department_id"] = departmentId;
    if (workShift != null) queryParameters["workshift"] = workShift;
    if (licenseKey != null) queryParameters["license_key"] = licenseKey;

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}attendance/list/",
    ).replace(queryParameters: queryParameters);

    return await fetchApiData(uri, (res) => AttendanceListModel.fromJson(res));
  }

  Future<BaseResponseModel> updateAttendanceById({
    required int attendanceId,
    required String licenseKey,
    String? checkInTime,
    String? checkOutTime,
    bool? presentOne,
    bool? presentTwo,
    String? workHours,
    String? overtimeHours,
    bool? isOvertime,
  }) async {
    final Uri url = Uri.parse(
      "${ApiConstants.baseUrl}attendance/update/$attendanceId/",
    );

    // Prepare data map
    Map<String, dynamic> updatedData = {
      "license_key": licenseKey,
      "check_in_time": checkInTime,
      "check_out_time": checkOutTime,
      "present_one": presentOne,
      "present_two": presentTwo,
      "work_hours": workHours,
      "overtime_hours": overtimeHours,
      "is_overtime": isOvertime, // "true" or "false"
    };

    // Remove nulls so only sent fields are updated
    updatedData.removeWhere((key, value) => value == null);

    try {
      final response = await patchApiData<BaseResponseModel>(
        url,
        updatedData,
        BaseResponseModel.fromJson,
      );
      return response;
    } catch (e, stack) {
      log("Error updating attendance: $e", stackTrace: stack);
      rethrow;
    }
  }

  Future<BaseResponseModel> addOrUpdateEmployeeLeave({
    required String licenseKey,
    required int employeeId,
    required int leaveTypeId,
    required int leaveCount,
    int? leaveDetailId,
  }) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}employee-leave/add-or-update/",
    );
    final body = {
      "license_key": licenseKey,
      "employee_id": employeeId,
      "leave_type_id": leaveTypeId,
      "leave_count": leaveCount,
      if (leaveDetailId != null) "leave_detail_id": leaveDetailId,
    };

    return postApiData(url, body, (json) => BaseResponseModel.fromJson(json));
  }

  Future<LeaveRequestFilterModel> filterLeaveRequests({
    required String licenseKey,
    int? employeeId,
    String? status,
    String? startDate, // format: YYYY-MM-DD
    String? endDate,
  }) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}leaves/filter/");

    final body = {
      "license_key": licenseKey,
      if (employeeId != null) "employee_id": employeeId,
      if (status != null) "status": status,
      if (startDate != null) "start_date": startDate,
      if (endDate != null) "end_date": endDate,
    };

    return postApiData(
      uri,
      body,
      (json) => LeaveRequestFilterModel.fromJson(json),
    );
  }

  Future<BaseResponseModel> requestLeave({
    required String licenseKey,
    required int employeeId,
    required int leaveTypeId,
    required String startDate,
    required String endDate,
    String? remarks,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}leave/request/");
    final body = {
      "license_key": licenseKey,
      "employee_id": employeeId,
      "leave_type_id": leaveTypeId,
      "start_date": startDate,
      "end_date": endDate,
      "remarks": remarks ?? "",
    };

    return postApiData(url, body, (json) => BaseResponseModel.fromJson(json));
  }

  Future<BaseResponseModel> approveOrRejectLeave({
    required int leaveId,
    required String action, // "approve" or "reject"
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}leaves/action/");
    final body = {"leave_id": leaveId, "action": action};
    log("leave::${body.toString()}");
    return postApiData(url, body, BaseResponseModel.fromJson);
  }

  Future<HRDashboardModel> fetchDashboardData(String licenseKey) async {
    final url = Uri.parse("${ApiConstants.baseUrl}dashboard/hr/");
    final body = {"license_key": licenseKey};

    return await postApiData<HRDashboardModel>(
      url,
      body,
      (data) => HRDashboardModel.fromJson(jsonDecode(data)),
    );
  }

  Future<PayrollListModel> listPayrollRecords({
    required String licenseKey,
    String? fromDate,
    String? toDate,
    String? workShift,
    int? departmentId,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}list-payroll/");
    final body = {
      "license_key": licenseKey,
      if (fromDate != null) "from_date": fromDate,
      if (toDate != null) "to_date": toDate,
      if (workShift != null) "work_shift": workShift,
      if (departmentId != null) "department_id": departmentId,
    };

    return await postApiData<PayrollListModel>(
      url,
      body,
      (data) => PayrollListModel.fromJson(jsonDecode(data)),
    );
  }

  Future<PayrollGenerateResponseModel> generateOrUpdatePayroll({
    required String licenseKey,
    int? employeeId,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}payroll/generate/");
    final body = {
      "license_key": licenseKey,
      if (employeeId != null) "employee_id": employeeId,
    };

    return await postApiData<PayrollGenerateResponseModel>(
      url,
      body,
      (data) => PayrollGenerateResponseModel.fromJson(jsonDecode(data)),
    );
  }
}
