import 'dart:developer';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Bloc/bloc/employee_bloc.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:act/Features/EmployeeManagement/Models/simple_employee_list.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/add_employee_data.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeDetails/employee_details.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  final EmployeeBloc employee = EmployeeBloc();
  @override
  void initState() {
    // employee.add(EmployeeDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> getEmployeeDataRows(
      List<SimpleEmployeeModel> employeeData,
      String searchString,
    ) {
      final filteredList =
          employeeData.where((employee) {
            final lowerSearch = searchString.toLowerCase();

            return employee.fullName.toLowerCase().contains(lowerSearch) ||
                (employee.email ?? '').toLowerCase().contains(lowerSearch) ||
                (employee.department ?? '').toLowerCase().contains(
                  lowerSearch,
                ) ||
                (employee.designation ?? '').toLowerCase().contains(
                  lowerSearch,
                ) ||
                employee.gender.toLowerCase().contains(lowerSearch) ||
                (employee.workStatus ? "active" : "inactive")
                    .toLowerCase()
                    .contains(lowerSearch);
          }).toList();

      return employeeData.map((employee) {
        return DataRow(
          cells: [
            DataCell(Text(employee.fullName)),
            DataCell(Text(employee.email ?? '-')),
            DataCell(Text(employee.department ?? '-')),
            DataCell(Text(employee.designation ?? '-')),
            DataCell(Text(employee.gender)),
            DataCell(
              Text(employee.dateOfJoin ?? "-"),
            ), // Placeholder for Date of Joining
            DataCell(Text(employee.workStatus ? "Active" : "Inactive")),

            DataCell(
              InkWell(
                onTap: () {
                  log(employee.id.toString());
                  // employeeBloc.add(EmployeeDetail(employeeId: employee.id));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => AddEmployeeData(employeeId: employee.id),
                    ),
                  );
                },
                child: Icon(Icons.edit, color: Colors.black),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  log(employee.id.toString());
                  // employeeBloc.add(EmployeeDetail(employeeId: employee.id));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => EmployeeDetails(employeeID: employee.id),
                    ),
                  );
                },
                child: Icon(Icons.edit),
              ),
            ),
          ],
        );
      }).toList();
    }

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomDrawer(employeeManagement: true, allEmployee: true),
          ),
          Expanded(
            flex: 12,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(
                  child: Container(
                    color: cardsColors,
                    child: Column(
                      children: [
                        SizedBox(
                          width: calcSize(context).longestSide,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.small(
                                    "Employee Management",
                                    fontSize: 18,
                                  ),
                                  07.sp.width,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  07.sp.width,
                                  AppText.small("All Employee", fontSize: 18),
                                ],
                              ),
                              AppText.medium("All Employee", fontSize: 18),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AllEmployeeFilter(
                                  employeeBloc: employee,
                                ).withPadding(padding: EdgeInsets.all(07.sp)),
                                10.height,
                                BlocConsumer<EmployeeBloc, EmployeeState>(
                                  bloc: employee..add(EmployeeDataEvent()),
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state is EmployeeDataState) {
                                      log(state.modelData.toString());
                                      return CustomTable(
                                        datacolumns: [
                                          'Name',
                                          'Email Id',
                                          'Department',
                                          'Designation',
                                          'Gender',
                                          'Date of Joining',
                                          'Status',
                                          'Action',
                                          'Info',
                                        ],
                                        dataRow: getEmployeeDataRows(
                                          state.modelData,
                                          searchController.text,
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                        child: Center(
                                          child: AppText.small(
                                            "No Data Available!",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                // 10.height,
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Container(
                                //       height: 17.sp,
                                //       width: 30.sp,
                                //       decoration: BoxDecoration(
                                //         color: Colors.amber,
                                //         borderRadius: BorderRadius.circular(
                                //           07.sp,
                                //         ),
                                //       ),
                                //       child: Center(
                                //         child: AppText.small(
                                //           "Prev",
                                //           fontSize: 11.sp,
                                //         ),
                                //       ),
                                //     ),
                                //     10.width,
                                //     Container(
                                //       height: 17.sp,
                                //       width: 30.sp,
                                //       decoration: BoxDecoration(
                                //         color: Colors.amber,
                                //         borderRadius: BorderRadius.circular(
                                //           07.sp,
                                //         ),
                                //       ),
                                //       child: Center(
                                //         child: AppText.small(
                                //           "Next",
                                //           fontSize: 11.sp,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ).withPadding(padding: EdgeInsets.all(10.sp)),
                          ),
                        ),
                      ],
                    ).withPadding(padding: EdgeInsets.all(10.sp)),
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

class AllEmployeeFilter extends StatefulWidget {
  final EmployeeBloc employeeBloc;
  const AllEmployeeFilter({super.key, required this.employeeBloc});

  @override
  State<AllEmployeeFilter> createState() => _AllEmployeeFilterState();
}

class _AllEmployeeFilterState extends State<AllEmployeeFilter> {
  String? departmentController;
  String? designationController;
  String? genderController;
  String? workShiftController;
  String? selectedDepartmentName;
  final activeDepartments =
      deparment.departments!.where((e) => e.isActive == true).toList();
  int? selectedDepartmentId;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "Search",
            controller: searchController,
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Gender",
            dropDownMenu: gender,
            selectedItem: genderController,
            onChanged: (value) {
              genderController = value!;
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
        // SizedBox(
        //   width: 40.sp,
        //   child: CustomBorderDropDownForm(
        //     hintText: "Designation",
        //     dropDownMenu:
        //         designation.designations!
        //             .map((e) => e.designationName ?? "")
        //             .toList(),
        //     selectedItem: designationController,
        //     onChanged: (value) {
        //       designationController = value!;
        //     },
        //   ),
        // ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Work shift",
            dropDownMenu: workShift,
            selectedItem: workShiftController,
            onChanged: (value) {
              workShiftController = value!;
            },
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmployeeManagement(),
                  ),
                );
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
                widget.employeeBloc.add(
                  EmployeeDataEvent(
                    department: selectedDepartmentName,
                    gender: genderController,
                    workShift: workShiftController,
                  ),
                );
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
    );
  }
}
