import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/Configuration/Models/holiday_list_model.dart';
import 'package:act/Features/Configuration/Models/leave_type_list_model.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:flutter/foundation.dart';

Future<void> fetchDepartmentsAndDesignations() async {
  final ConfigurationRepo configurationRepo = ConfigurationRepo();
  try {
    final session = SessionManagerClass();
    var licenseKey = await session.getlicence();
    // Fetch departments
    DepartmentListModel fetchedDepartments = await configurationRepo
        .listDeparmentApi(licenseKey);
    deparment = fetchedDepartments;

    // Fetch designations
    DesingantionListModel fetchedDesignations = await configurationRepo
        .listDesignationApi(licenseKey);
    designation = fetchedDesignations;

    // Optional: log or trigger UI update
    if (kDebugMode) {
      print("Departments: ${deparment.departments?.length ?? 0}");
      print("Designations: ${designation.designations?.length ?? 0}");
    }

    LeaveTypeListModel fetchedLeaveTypes = await configurationRepo
        .listLeaveTypes(licenseKey);
    leaveTypeListModel = fetchedLeaveTypes;

    // Fetch holidays
    HolidayListModel fetchedHolidays = await configurationRepo.listHolidays(
      licenseKey,
    );
    holidaylist = fetchedHolidays;

    // Debug logs
    if (kDebugMode) {
      print("Leave Types: ${leaveTypeListModel.leaveTypes?.length ?? 0}");
      print("Holidays: ${holidaylist.leaves?.length ?? 0}");
    }
  } catch (e) {
    debugPrint("Error fetching data: $e");
    // Handle error: show snackbar, toast, or fallback logic
  }
}
