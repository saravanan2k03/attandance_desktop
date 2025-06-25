import 'package:act/Core/Services/api_network_services.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/EmployeeManagement/Models/base_response.dart';
import 'package:act/Features/HrManagement/Models/attendance_list_model.dart';
import 'package:act/Features/HrManagement/Models/device_list_model.dart';
import 'package:act/Features/HrManagement/Models/update_attendance_record_model.dart';

class HrRepository {
  // Future<DeviceAddModel> addDevice({
  //   required String licenseKey,
  //   required String deviceName,
  //   required String deviceIp,
  //   required String devicePort,
  //   required String syncInterval,
  //   required String lastSyncInterval,
  //   required bool isActive,
  // }) async {
  //   final url = Uri.parse("${ApiConstants.baseUrl}devices/add/");

  //   final body = {
  //     "license_key": licenseKey,
  //     "device_name": deviceName,
  //     "device_ip": deviceIp,
  //     "device_port": devicePort,
  //     "sync_interval": syncInterval,
  //     "last_sync_interval": lastSyncInterval,
  //     "is_active": isActive,
  //   };

  //   return postApiData(url, body, (json) => DeviceAddModel.fromJson(json));
  // }

  Future<DeviceListModel> listDevices(String licenseKey) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}devices/list/?license_key=$licenseKey",
    );

    return fetchApiData(url, (json) => DeviceListModel.fromJson(json));
  }

  Future<DeviceListModel> updateDevice({
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

    return patchApiData(url, body, (json) => DeviceListModel.fromJson(json));
  }

  Future<AttendanceListModel> listAttendance({
    required String licenseKey,
    required String fromDate,
    required String toDate,
    required String workshift,
    required int departmentId,
  }) async {
    final queryParams =
        "license_key=$licenseKey&from_date=$fromDate&to_date=$toDate&workshift=$workshift&department_id=$departmentId";

    final url = Uri.parse(
      "${ApiConstants.baseUrl}attendance/list/?$queryParams",
    );

    return fetchApiData(url, (json) => AttendanceListModel.fromJson(json));
  }

  Future<UpdateAttendanceRecordModel> updateAttendanceRecord({
    required String licenseKey,
    required int employeeId,
    required String date,
    String? checkInTime,
    String? checkOutTime,
    bool? presentOne,
    bool? presentTwo,
    String? workHours,
    bool? isOvertime,
    String? overtimeHours,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}attendance/update/");

    // Construct body dynamically based on what's provided
    final body = {
      "license_key": licenseKey,
      "employee_id": employeeId,
      "date": date,
      if (checkInTime != null) "check_in_time": checkInTime,
      if (checkOutTime != null) "check_out_time": checkOutTime,
      if (presentOne != null) "present_one": presentOne,
      if (presentTwo != null) "present_two": presentTwo,
      if (workHours != null) "work_hours": workHours,
      if (isOvertime != null) "is_overtime": isOvertime,
      if (overtimeHours != null) "overtime_hours": overtimeHours,
    };

    return putApiData(
      url,
      body,
      (json) => UpdateAttendanceRecordModel.fromJson(json),
    );
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
    final url = Uri.parse("${ApiConstants.baseUrl}leave/action/");
    final body = {"leave_id": leaveId, "action": action};

    return postApiData(url, body, (json) => BaseResponseModel.fromJson(json));
  }
}
