import 'dart:convert';
import 'dart:developer';

import 'package:act/Core/Services/api_network_services.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/EmployeeManagement/Models/base_response.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_dashboard.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_detail_reponse.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_leave_detail_model.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_leave_details.dart';
import 'package:act/Features/EmployeeManagement/Models/leave_details_model.dart';
import 'package:act/Features/EmployeeManagement/Models/leave_requset_model.dart';
import 'package:act/Features/EmployeeManagement/Models/simple_employee_list.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeRepo {
  Future<List<SimpleEmployeeModel>> getSimpleEmployeeList({
    required String licenseKey,
    String? gender,
    String? department,
    String? designation,
    String? workShift,
  }) async {
    final queryParams = {
      'license_key': licenseKey,
      if (gender != null) 'gender': gender,
      if (department != null) 'department': department,
      if (designation != null) 'designation': designation,
      if (workShift != null) 'work_shift': workShift,
    };

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}employees/list/",
    ).replace(queryParameters: queryParams);

    return await fetchApiData(
      uri,
      (json) => SimpleEmployeeModel.listFromJson(json),
    );
  }

  Future<EmployeeLeaveDetailResponse> getEmployeeLeaveDetailByUserIds(
    int userId,
  ) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}employee/$userId/");
    return await fetchApiData(
      uri,
      (json) => EmployeeLeaveDetailResponse.fromJson(jsonDecode(json)),
    );
  }

  Future<LeaveRequestResponse> requestLeave({
    int? employeeId,
    required String leaveType,
    required String startDate,
    required String endDate,
    String remarks = '',
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}leaves/request/");

    final body = {
      "leave_type": leaveType,
      "start_date": startDate,
      "end_date": endDate,
      "remarks": remarks,
      if (employeeId != null) "employee_id": employeeId,
    };

    return await postApiData(
      url,
      body,
      (body) => LeaveRequestResponse.fromJson(body),
    );
  }

  Future<BaseResponseModel> addOrUpdateEmployee({
    required String licenseKey,
    required String email,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
    required String nationality,
    required String iqamaNumber,
    required String mobNo,
    required String joiningDate,
    required String workStatus,
    required String basicSalary,
    required bool gosiApplicable,
    required String departmentId,
    required String designationId,
    required List<Map<String, dynamic>> leaveDetails,
    required String filename,
    required String address,
    required String fingerPrintCode,
    required String workshift,
    String? username, // Required only if creating a new employee
    String? password,
    String? employeeId, // Required only if updating
    String? gosiDeductionAmount,
    String? overTimeSalary,
    XFile? profilePic,
    XFile? document,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}employees/add-or-update/");

    final Map<String, dynamic> fields = {
      "license_key": licenseKey,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "nationality": nationality,
      "iqama_number": iqamaNumber,
      "mob_no": mobNo,
      "joining_date": joiningDate,
      "work_status": workStatus,
      "basic_salary": basicSalary,
      "gosi_applicable": gosiApplicable.toString(),
      "filename": filename,
      "address": address,
      "finger_print_code": fingerPrintCode,
      "department_id": departmentId,
      "designation_id": designationId,
      "workshift": workshift,
      "leave_details": jsonEncode(leaveDetails),
    };

    // Optional fields (included only if not null)
    if (username != null) fields["username"] = username;
    if (password != null) fields["password"] = password;
    if (employeeId != null) fields["employee_id"] = employeeId;
    if (gosiDeductionAmount != null) {
      fields["gosi_deduction_amount"] = gosiDeductionAmount;
    }
    if (overTimeSalary != null) fields["over_time_salary"] = overTimeSalary;
    log(fields.toString());
    return postApiDataWithImage(
      url,
      profilePic,
      document,
      fields,
      (json) => BaseResponseModel.fromJson(json),
    );
  }

  Future<List<EmployeeLeaveDetailModel>> getEmployeeLeaveDetailsByUserId(
    int userId,
  ) async {
    final Uri url = Uri.parse(
      "${ApiConstants.baseUrl}leave-details/by-user/$userId/",
    );
    return await fetchApiData(url, EmployeeLeaveDetailModel.listFromJson);
  }

  Future<LeaveDetailResponseModel> addOrUpdateEmployeeLeaveDetails({
    required String licenseKey,
    required int employeeId,
    required int leaveTypeId,
    required int leaveCount,
    int? leaveDetailId,
  }) async {
    final String url =
        "${ApiConstants.baseUrl}employees/leave-details/add-or-update/";
    final Uri uri = Uri.parse(url);

    final Map<String, dynamic> body = {
      "license_key": licenseKey,
      "employee_id": employeeId,
      "leave_type_id": leaveTypeId,
      "leave_count": leaveCount,
    };

    if (leaveDetailId != null) {
      body["leave_detail_id"] = leaveDetailId;
    }

    return postApiData(
      uri,
      body,
      (json) => LeaveDetailResponseModel.fromJson(json),
    );
  }

  Future<LeaveRequestResponse> filterLeaveRequests({
    required String licenseKey,
    String? employeeId,
    int? employeeUserId,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    final payload = {
      // "license_key": licenseKey,
      if (employeeId != null) "employee_id": employeeId,
      if (employeeUserId != null) "employee_user_id": employeeUserId,
      if (status != null) "status": status,
      if (startDate != null) "start_date": startDate,
      if (endDate != null) "end_date": endDate,
    };
    log(payload.toString());

    final url = Uri.parse("${ApiConstants.baseUrl}leaves/filter/");

    return await postApiData(
      url,
      payload,
      (json) => LeaveRequestResponse.fromJson(json),
    );
  }

  Future<EmployeeDashboardModel> fetchEmployeeDashboard({
    required String employeeId,
    required String licenceKey,
  }) async {
    final queryParams = {'employee_id': employeeId, "license_key": licenceKey};
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}attendance/dashboard/",
    ).replace(queryParameters: queryParams);

    return await fetchApiData<EmployeeDashboardModel>(
      uri,
      (resBody) => EmployeeDashboardModel.fromJson(jsonDecode(resBody)),
    );
  }

  Future<EmployeeDetailResponse> getEmployeeDetails(int employeeId) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}employees/$employeeId/details/",
    );

    final response = await fetchApiData(
      url,
      (json) => EmployeeDetailResponse.fromJson(jsonDecode(json)),
    );

    return response;
  }
}
