import 'package:act/Core/Constants/constant.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:flutter/foundation.dart';

Future<void> fetchDepartmentsAndDesignations(String licenseKey) async {
  final ConfigurationRepo configurationRepo = ConfigurationRepo();
  try {
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
  } catch (e) {
    debugPrint("Error fetching data: $e");
    // Handle error: show snackbar, toast, or fallback logic
  }
}
