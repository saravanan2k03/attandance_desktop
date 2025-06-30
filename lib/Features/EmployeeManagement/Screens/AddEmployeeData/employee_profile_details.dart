import 'dart:developer';

import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:act/Features/EmployeeManagement/Widgets/add_leave_diaglogue.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class EmployeeProfileDetails extends StatefulWidget {
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final ValueNotifier<String?> departmentController;
  final ValueNotifier<String?> designationController;
  final TextEditingController basicSalaryController;
  final TextEditingController overTimeSalaryController;
  final TextEditingController gosiDeductionController;
  final ValueNotifier<String?> workShiftController;
  final ValueNotifier<String?> userTypeController;
  final TextEditingController addressController;
  final TextEditingController fingerprintcode;

  EmployeeProfileDetails({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required this.departmentController,
    required this.designationController,
    required this.basicSalaryController,
    required this.gosiDeductionController,
    required this.workShiftController,
    required this.userTypeController,
    required this.addressController,
    required this.fingerprintcode,
    required this.overTimeSalaryController,
  });

  @override
  State<EmployeeProfileDetails> createState() => _EmployeeProfileDetailsState();
}

class _EmployeeProfileDetailsState extends State<EmployeeProfileDetails> {
  final activeDepartments =
      deparment.departments!.where((e) => e.isActive == true).toList();
  final activeDesignations = designation.designations!.toList();
  int? selectedDepartmentId;
  int? selectedDesignationId;

  @override
  void initState() {
    log("workShift:${widget.workShiftController.toString()}");
    super.initState();
    // Initialize the designation if it was previously set
    if (widget.designationController.value != null) {
      try {
        final designationId = int.parse(widget.designationController.value!);
        final designation = activeDesignations.firstWhere(
          (d) => d.id == designationId,
          orElse: () => activeDesignations.first,
        );
        selectedDesignationId = designation.id;
      } catch (e) {
        print('Error initializing designation: $e');
      }
    }
  }

  String? _getDepartmentName(String? id) {
    if (id == null) return null;
    try {
      return activeDepartments
          .firstWhere((dept) => dept.id?.toString() == id)
          .departmentName;
    } catch (e) {
      debugPrint('Department not found for ID: $id');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calcSize(context).longestSide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Employee Profile Details", fontSize: 17),
          10.height,
          Wrap(
            spacing: 10.sp,
            runSpacing: 10.sp,
            children: [
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "User Name",
                  controller: widget.userNameController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Password",
                  controller: widget.passwordController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Finger Code",
                  controller: widget.fingerprintcode,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomBorderDropDownForm(
                  hintText: "Department",
                  dropDownMenu:
                      activeDepartments
                          .map((e) => e.departmentName ?? "")
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      try {
                        final dept = activeDepartments.firstWhere(
                          (dept) => dept.departmentName == value,
                        );
                        widget.departmentController.value = dept.id?.toString();
                      } catch (e) {
                        debugPrint('Error selecting department: $e');
                        widget.departmentController.value = null;
                      }
                    }
                  },
                  selectedItem: _getDepartmentName(
                    widget.departmentController.value,
                  ),
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomBorderDropDownForm(
                  hintText: "Designation",
                  dropDownMenu:
                      designation.designations!
                          .map((e) => e.designationName ?? "")
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      try {
                        final selectedDesignation = activeDesignations
                            .firstWhere((d) => d.designationName == value);
                        widget.designationController.value =
                            selectedDesignation.id?.toString();
                        selectedDesignationId = selectedDesignation.id;
                        print(
                          "Selected designation ID: ${selectedDesignation.id}",
                        );
                      } catch (e) {
                        print('Error setting designation: $e');
                        widget.designationController.value = null;
                        selectedDesignationId = null;
                      }
                    }
                  },
                  selectedItem:
                      widget.designationController.value != null
                          ? activeDesignations
                              .firstWhere(
                                (d) =>
                                    d.id?.toString() ==
                                    widget.designationController.value,
                                orElse: () => activeDesignations.first,
                              )
                              .designationName
                          : null,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Basic Salary",
                  controller: widget.basicSalaryController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Over Time Salary",
                  controller: widget.overTimeSalaryController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Gosi deduction amount",
                  controller: widget.gosiDeductionController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomBorderDropDownForm(
                  hintText: "Work Shift",
                  dropDownMenu: workShift,
                  onChanged: (value) {
                    widget.workShiftController.value = value!;
                  },
                  selectedItem: widget.workShiftController.value,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomBorderDropDownForm(
                  hintText: "User Type",
                  dropDownMenu: const ["Admin", "employee", "Hr"],
                  onChanged: (value) {
                    if (value != null) {
                      widget.userTypeController.value = value;
                    }
                  },
                  selectedItem: widget.userTypeController.value,
                ),
              ),
            ],
          ),
          10.height,
          SizedBox(
            height: 50.sp,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.small("Gosi Applicable", fontSize: 17),
                      10.height,
                      Container(
                        height: 20.sp,
                        width: 50.sp,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(07.sp),
                        ),
                        child: TabToggleWidget(),
                      ),
                      10.height,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                          child: TextField(
                            controller: widget.addressController,
                            maxLines:
                                null, // Allows the TextField to grow vertically
                            expands: true, // Expands to fill available height
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintText: "Enter address...",
                              contentPadding: EdgeInsets.all(07.sp),
                              border:
                                  InputBorder
                                      .none, // Remove inner border since outer has one
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                07.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AddLeaveDialog(
                                  leaveTypes:
                                      leaveTypeListModel.leaveTypes!
                                          .map((e) => e.leaveType ?? "")
                                          .toList(),
                                  onSubmit: (selectedLeave, count) {
                                    print(selectedLeave + count.toString());
                                    setState(() {
                                      leaveData.add({
                                        "leave_type":
                                            selectedLeave.toString() as Object,
                                        "leave_count":
                                            count.toString() as Object,
                                      });
                                    });
                                  },
                                ),
                          );
                        },
                        child: Container(
                          height: 20.sp,
                          width: 30.sp,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                          child: Center(
                            child: AppText.small("ADD", fontSize: 17),
                          ),
                        ),
                      ),
                      07.height,
                      CustomTable(
                        datacolumns: ['ID', 'Leave', 'Count', 'Action'],
                        dataRow:
                            leaveData.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;

                              return DataRow(
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Text(item['leave_type'] as String)),
                                  DataCell(Text('${item['leave_count']}')),
                                  DataCell(
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          leaveData.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabToggleWidget extends StatefulWidget {
  const TabToggleWidget({super.key});

  @override
  State<TabToggleWidget> createState() => _TabToggleWidgetState();
}

class _TabToggleWidgetState extends State<TabToggleWidget> {
  String selected = "Applicable"; // Default selected tab
  @override
  void initState() {
    if (gosiApplicable) {
      selected = "Applicable";
    } else {
      selected = "Not Applicable";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = calcSize(context).longestSide;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = "Applicable";
              });
              gosiApplicable = true;
              print("Selected: $selected");
            },
            child: Container(
              height: size,
              decoration: BoxDecoration(
                color:
                    selected == "Applicable" ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(
                child: AppText.small(
                  "Applicable",
                  fontSize: 17,
                  color: selected == "Applicable" ? Colors.white : Colors.black,
                ),
              ),
            ).withPadding(padding: EdgeInsets.all(05.sp)),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = "Not Applicable";
              });
              gosiApplicable = false;
              print("Selected: $selected");
            },
            child: Container(
              height: size,
              decoration: BoxDecoration(
                color:
                    selected == "Not Applicable"
                        ? Colors.blue
                        : Colors.grey[300],
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(
                child: AppText.small(
                  "Not Applicable",
                  fontSize: 17,
                  color:
                      selected == "Not Applicable"
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ).withPadding(padding: EdgeInsets.all(05.sp)),
          ),
        ),
      ],
    );
  }
}
