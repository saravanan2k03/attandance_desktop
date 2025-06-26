import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Bloc/bloc/employee_bloc.dart';
import 'package:act/Features/EmployeeManagement/Models/simple_employee_list.dart';
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
    employee.add(EmployeeDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
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

      return filteredList.map((employee) {
        return DataRow(
          cells: [
            DataCell(Text(employee.fullName)),
            DataCell(Text(employee.email ?? '-')),
            DataCell(Text(employee.department ?? '-')),
            DataCell(Text(employee.designation ?? '-')),
            DataCell(Text(employee.gender)),
            DataCell(Text(employee.workStatus ? "Active" : "Inactive")),
            DataCell(Text("N/A")), // Placeholder for Date of Joining
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
                                  searchController: searchController,
                                ).withPadding(padding: EdgeInsets.all(07.sp)),
                                10.height,
                                BlocConsumer<EmployeeBloc, EmployeeState>(
                                  bloc: employee,
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state is EmployeeDataState) {
                                      return CustomTable(
                                        datacolumns: [
                                          'Name',
                                          'Email Id',
                                          'Department',
                                          'Designation',
                                          'Gender',
                                          'Work Shift',
                                          'Date of Joining',
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

class AllEmployeeFilter extends StatelessWidget {
  final TextEditingController searchController;
  const AllEmployeeFilter({super.key, required this.searchController});

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
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Department",
            dropDownMenu:
                deparment.departments!
                    .where((e) => e.isActive == true)
                    .map((e) => e.departmentName ?? "")
                    .toList(),
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
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Work shift",
            dropDownMenu: workShift,
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 18.sp,
              width: 40.sp,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(child: AppText.small("Clear", fontSize: 17)),
            ),
            07.width,
            Container(
              height: 18.sp,
              width: 40.sp,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(child: AppText.small("Submit", fontSize: 17)),
            ),
          ],
        ),
      ],
    );
  }
}
