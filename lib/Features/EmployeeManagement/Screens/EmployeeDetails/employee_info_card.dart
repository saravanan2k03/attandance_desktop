import 'package:act/Features/EmployeeManagement/Bloc/bloc/employee_bloc.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_basic_cards.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class EmployeeInfoCard extends StatelessWidget {
  final int employeeId;
  const EmployeeInfoCard({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final EmployeeBloc employee = EmployeeBloc();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: BlocConsumer<EmployeeBloc, EmployeeState>(
        bloc: employee..add(EmployeeDetail(employeeId: employeeId)),
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EmployeeDetailDataState) {
            var modelData = state.modelData;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // spacing: 07.sp,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 15.sp,
                    ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                    10.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.small(
                            modelData.data.firstName,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: 11.sp,
                          ),
                          AppText.small(
                            modelData.data.designationName,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: 11.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.height,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.medium("Personal Info", fontSize: 11.sp),
                            EmployeeBasicCards(
                              label: "Nationality",
                              data: modelData.data.nationality,
                              customIcon: Icons.flag,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Gender",
                              data: modelData.data.gender,
                              customIcon: Icons.wc,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Department",
                              data: modelData.data.departmentName,
                              customIcon: Icons.apartment,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Work Shift",
                              data: modelData.data.workshift ?? "",
                              customIcon: Icons.schedule,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Date Of Birth",
                              data: modelData.data.dateOfBirth,
                              customIcon: Icons.cake,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Basic Salary",
                              data: modelData.data.basicSalary.toString(),
                              customIcon: Icons.attach_money,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "User Name",
                              data: modelData.data.username,
                              customIcon: Icons.person,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Gosi Applicable",
                              data:
                                  modelData.data.gosiApplicable
                                      ? "Applicable"
                                      : 'Not Applicable',
                              customIcon: Icons.verified_user,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                          ],
                        ),
                        10.height,
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.medium("Contact Info", fontSize: 11.sp),
                            EmployeeBasicCards(
                              label: "Mobile no",
                              data: modelData.data.mobNo,
                              customIcon: Icons.phone,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Iqma number",
                              data: modelData.data.iqamaNumber,
                              customIcon: Icons.badge,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "Email Id",
                              data: modelData.data.email,
                              customIcon: Icons.email,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                            EmployeeBasicCards(
                              label: "User type",
                              data: modelData.data.userType,
                              customIcon: Icons.supervised_user_circle,
                            ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                          ],
                        ),
                      ],
                    ).withPadding(padding: EdgeInsets.only(bottom: 10.sp)),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: AppText.small("No Data Available!"));
          }
        },
      ).withPadding(padding: EdgeInsets.symmetric(horizontal: 07.sp)),
    );
  }
}
