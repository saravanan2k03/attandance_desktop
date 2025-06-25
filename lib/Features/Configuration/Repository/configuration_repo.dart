import 'package:act/Core/Services/api_network_services.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/Configuration/Models/configuration_add_or_update_model.dart';
import 'package:act/Features/Configuration/Models/configuration_list_model.dart';
import 'package:act/Features/Configuration/Models/department_model.dart';
import 'package:act/Features/Configuration/Models/designation_add_model.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/Configuration/Models/holiday_add_update_model.dart';
import 'package:act/Features/Configuration/Models/holiday_list_model.dart';
import 'package:act/Features/Configuration/Models/leave_type_list_model.dart';
import 'package:act/Features/Configuration/Models/leave_type_model.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:act/Features/Configuration/Models/update_department_model.dart';

class ConfigurationRepo {
  Future<DepartmentaddModel> addDeparmentApi() async {
    ///Url//
    String addDeparmentrepoUrl =
        "${ApiConstants.baseUrl}${ApiConstants.adddepartments}";
    final url = Uri.parse(addDeparmentrepoUrl);
    return postApiData(url, {
      "license_key": "ORG-XYZ-1234",
      "name": "Human Resourcess",
    }, (json) => DepartmentaddModel.fromJson(json));
  }

  Future<DepartmentupdateModel> updateDeparmentApi(int id) async {
    ///Url//
    String updateDeparmentrepoUrl =
        "${ApiConstants.baseUrl}${ApiConstants.updatedepartment}$id/";
    final url = Uri.parse(updateDeparmentrepoUrl);
    return putApiData(url, {
      "name": "Marketing",
    }, (json) => DepartmentupdateModel.fromJson(json));
  }

  Future<DepartmentListModel> listDeparmentApi(String key) async {
    ///Url//
    String listDeparmentrepoUrl =
        "${ApiConstants.baseUrl}${ApiConstants.listdepartment}?license_key=$key";
    final url = Uri.parse(listDeparmentrepoUrl);
    return fetchApiData(url, (json) => DepartmentListModel.fromJson(json));
  }

  Future<DesignationaddModel> addDesignation() async {
    ///Url//
    String addDesignationrepoUrl =
        "${ApiConstants.baseUrl}${ApiConstants.adddesignation}";
    final url = Uri.parse(addDesignationrepoUrl);
    return postApiData(url, {
      "license_key": "ORG-XYZ-1234",
      "designation_name": "Software Engineers",
    }, (json) => DesignationaddModel.fromJson(json));
  }

  Future<DepartmentupdateModel> updateDesignationApi(int id) async {
    ///Url//
    String updateDesignationrepoUrl =
        "${ApiConstants.baseUrl}${ApiConstants.updatedesination}$id/";
    final url = Uri.parse(updateDesignationrepoUrl);
    return putApiData(url, {
      "designation_name": "Senior Software Engineer",
    }, (json) => DepartmentupdateModel.fromJson(json));
  }

  Future<DesingantionListModel> listDesignationApi(String key) async {
    ///Url//
    String listDeparmentrepoUrl =
        "${ApiConstants.baseUrl}${ApiConstants.listdepartment}?license_key=$key";
    final url = Uri.parse(listDeparmentrepoUrl);
    return fetchApiData(url, (json) => DesingantionListModel.fromJson(json));
  }

  Future<HolidayAddorUpdateModel> addOrUpdateHoliday({
    required int id,
    required String licenseKey,
    required String leaveName,
    required String leaveDate,
    required int createdBy,
    required bool isActive,
  }) async {
    /// URL
    String urlStr = "${ApiConstants.baseUrl}holidays/add-or-update/";
    final url = Uri.parse(urlStr);

    /// Body
    final body = {
      "id": id,
      "license_key": licenseKey,
      "leave_name": leaveName,
      "leave_date": leaveDate,
      "created_by": createdBy,
      "is_active": isActive,
    };

    /// Call API
    return postApiData(
      url,
      body,
      (json) => HolidayAddorUpdateModel.fromJson(json),
    );
  }

  Future<HolidayListModel> listHolidays(String licenseKey) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}holidays/list/?license_key=$licenseKey",
    );

    return fetchApiData(url, (json) => HolidayListModel.fromJson(json));
  }

  Future<ConfigAddOrUpdateModel> addOrUpdateConfig({
    required String licenseKey,
    required String workshift,
    required String punchInStartTime,
    required String punchInEndTime,
    required String punchInStartLateTime,
    required String punchInEndLateTime,
    required String punchOutStartTime,
    required String punchOutEndTime,
    required String overTimeWorkingEndTime,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}config/add-or-update/");

    final body = {
      "license_key": licenseKey,
      "workshift": workshift,
      "punch_in_start_time": punchInStartTime,
      "punch_in_end_time": punchInEndTime,
      "punch_in_start_late_time": punchInStartLateTime,
      "punch_in_end_late_time": punchInEndLateTime,
      "punch_out_start_time": punchOutStartTime,
      "punch_out_end_time": punchOutEndTime,
      "over_time_working_end_time": overTimeWorkingEndTime,
    };

    return postApiData(
      url,
      body,
      (json) => ConfigAddOrUpdateModel.fromJson(json),
    );
  }

  Future<ConfigurationListModel> listConfiguration(String licenseKey) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}configurations/?license_key=$licenseKey",
    );

    return fetchApiData(url, (json) => ConfigurationListModel.fromJson(json));
  }

  Future<LeaveTypeModel> addOrUpdateLeaveType({
    required String licenseKey,
    required String leaveType,
    required bool isActive,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}leave-type/");

    final body = {
      "license_key": licenseKey,
      "leave_type": leaveType,
      "is_active": isActive,
    };

    return postApiData(url, body, (json) => LeaveTypeModel.fromJson(json));
  }

  Future<LeaveTypeListModel> listLeaveTypes(String licenseKey) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}leave-type/list/?license_key=$licenseKey",
    );

    return fetchApiData(url, (json) => LeaveTypeListModel.fromJson(json));
  }
}
