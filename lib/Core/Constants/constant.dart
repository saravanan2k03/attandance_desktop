import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Services/toaster_services.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/Configuration/Models/holiday_list_model.dart';
import 'package:act/Features/Configuration/Models/leave_type_list_model.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const desktopConstraints = 1100;
const mobileConstraints = 600;
Color commonColor = Color(0xffd1e4ff);
Color cardsColors = Color(0xfff5f5f5);
var usertypeforappbar = "admin";
var adminUserList = ["Hr", "Admin", "Super Admin"];
var globallicenseKey = "";
var gender = ['Male', "Female", "Other"];
List<String> leaveAction = ["Pending", "Approved", "Rejected"];
DepartmentListModel deparment = DepartmentListModel(departments: []);
DesingantionListModel designation = DesingantionListModel(designations: []);
HolidayListModel holidaylist = HolidayListModel();
LeaveTypeListModel leaveTypeListModel = LeaveTypeListModel();
var attandanceCategory = ["Present", "Absent", "Late", "On Early", "On Leave"];
var workShift = ['Morning', 'Night', 'Evening'];

Future<void> getuserType() async {
  final session = SessionManagerClass();
  usertypeforappbar = await session.getusertype();
  globallicenseKey = await session.getlicence();
}

final ToasterService toasterService = ToasterService();
Size calcSize(context) {
  return MediaQuery.of(context).size;
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.initialValue,
    required this.enable,
    this.onChanged,
    this.readOnly,
    this.onTap,
  });

  final String title;
  final String initialValue;
  final bool enable;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        label: AppText.small(title, fontSize: 11.sp),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(),
        disabledBorder: const OutlineInputBorder(),

        // fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 07.sp,
          vertical: 08.sp,
        ),
      ),
      style: TextStyle(fontSize: 11.sp, color: Colors.black),
      onTap: onTap,
    );
  }
}

Future<String> selectDate(BuildContext context) async {
  DateTime? picked;
  String date = "";
  picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    date = picked.toString().split(" ")[0];
    return date;
  } else {
    return date;
  }
}

Future<String> selectTime(BuildContext context) async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null) {
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );
    final formattedTime = TimeOfDay.fromDateTime(
      dt,
      // ignore: use_build_context_synchronously
    ).format(context); // e.g., 8:00 AM
    return formattedTime;
  } else {
    return "";
  }
}

class CustomTextFormFieldwithcontroller extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool? readOnly;
  final Function()? onTap;
  final bool? enable;

  const CustomTextFormFieldwithcontroller({
    super.key,
    required this.title,
    required this.controller,
    this.readOnly,
    this.onTap,
    this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      onTap: onTap,
      enabled: enable ?? true,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      ),
    );
  }
}
