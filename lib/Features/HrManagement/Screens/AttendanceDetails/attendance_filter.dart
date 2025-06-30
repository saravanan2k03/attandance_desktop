import 'package:act/Core/Constants/constant.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_dropdown.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:act/Features/HrManagement/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class AttendanceFilter extends StatefulWidget {
  final TextEditingController searchController;
  final AttendanceBloc attendanceBloc;
  final String searchvalue;
  final Function(String)? onChanged;
  const AttendanceFilter({
    super.key,
    required this.searchController,
    required this.attendanceBloc,
    required this.searchvalue,
    this.onChanged,
  });

  @override
  State<AttendanceFilter> createState() => _AttendanceFilterState();
}

class _AttendanceFilterState extends State<AttendanceFilter> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  // Added controller for search

  // Separate variables for each dropdown
  String? selectedWorkShift;

  String? selectedDepartmentName;
  final activeDepartments =
      deparment.departments!.where((e) => e.isActive == true).toList();
  int? selectedDepartmentId;

  @override
  void initState() {
    if (widget.searchvalue.isEmpty) {
      widget.attendanceBloc.add(AttendanceListEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(
          width: 40.sp,
          child: CustomTextFormField(
            title: "Search",
            initialValue: widget.searchvalue,
            enable: true,
            onChanged: widget.onChanged,
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "From",
            controller: fromDateController,
            readOnly: true,
            onTap: () {
              selectDate(context).then((value) {
                fromDateController.text = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "To",
            controller: toDateController,
            readOnly: true,
            onTap: () {
              selectDate(context).then((value) {
                toDateController.text = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: MyDropdown(
            hintText: "Work shift",
            dropDownMenu: workShift,
            selectedItem: selectedWorkShift, // Use separate variable
            onChanged: (value) {
              setState(() {
                selectedWorkShift = value;
              });
            },
          ),
        ),

        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Department",
            dropDownMenu:
                activeDepartments.map((e) => e.departmentName ?? "").toList(),
            selectedItem: selectedDepartmentName,
            onChanged: (value) {
              setState(() {
                selectedDepartmentName = value;
                selectedDepartmentId =
                    activeDepartments
                        .firstWhere((dept) => dept.departmentName == value)
                        .id;
              });
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  // Clear all fields
                  selectedWorkShift = null;
                  selectedDepartmentName = null;
                  selectedDepartmentId = null;
                  widget.searchController.clear();
                  fromDateController.clear();
                  toDateController.clear();
                  widget.attendanceBloc.add(AttendanceListEvent());
                });
              },
              child: Container(
                height: 18.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Clear", fontSize: 17)),
              ),
            ),
            07.width,
            InkWell(
              onTap: () {
                // Add your submit logic here
                if (kDebugMode) {
                  print("Search: ${widget.searchController.text}");
                  print("From: ${fromDateController.text}");
                  print("To: ${toDateController.text}");
                  print("Work Shift: $selectedWorkShift");
                  print("Category: $selectedDepartmentName");
                }
                widget.attendanceBloc.add(
                  AttendanceListEvent(
                    fromDate:
                        fromDateController.text.isNotEmpty
                            ? fromDateController.text
                            : null,
                    toDate:
                        toDateController.text.isNotEmpty
                            ? toDateController.text
                            : null,
                    workShift: selectedWorkShift,
                    departmentId: selectedDepartmentId?.toString(),
                  ),
                );
                // showUpdateAttendanceDialog(
                //   context: context,
                //   recordId: 1,
                //   onSuccess: () {},
                // );
              },
              child: Container(
                height: 18.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Submit", fontSize: 17)),
              ),
            ),
          ],
        ),
      ],
    ).withPadding(padding: EdgeInsets.all(07.sp));
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    widget.searchController.dispose();
    super.dispose();
  }
}
