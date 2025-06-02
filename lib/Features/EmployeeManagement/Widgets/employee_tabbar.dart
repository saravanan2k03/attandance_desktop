import 'package:act/Core/Constants/constant.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class EmployeeTabbar extends StatefulWidget {
  const EmployeeTabbar({super.key});

  @override
  State<EmployeeTabbar> createState() => _EmployeeTabbarState();
}

class _EmployeeTabbarState extends State<EmployeeTabbar> {
  void changetabbar(
    bool employeeDashboard,
    bool employeeInformation,
    bool leaveRequest,
  ) {
    employeeDashboardvar = employeeDashboard;
    employeeInformationvar = employeeInformation;
    leaveRequestvar = leaveRequest;
  }

  @override
  void initState() {
    employeeDashboardvar = true;
    employeeInformationvar = false;
    leaveRequestvar = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xfff5f5f5),
            borderRadius: BorderRadius.circular(07.sp),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    changetabbar(
                      employeeDashboardvar = true,
                      employeeInformationvar = false,
                      leaveRequestvar = false,
                    );
                  });
                },

                child: TabbarCard(
                  cardenable: employeeDashboardvar,
                  label: "Employee Dashboard",
                ),
              ),

              InkWell(
                onTap: () {
                  setState(() {
                    changetabbar(
                      employeeDashboardvar = false,
                      employeeInformationvar = false,
                      leaveRequestvar = true,
                    );
                  });
                },
                child: TabbarCard(
                  cardenable: leaveRequestvar,
                  label: "Leave Request",
                ),
              ),
            ],
          ).withPadding(padding: EdgeInsets.all(07.sp)),
        ).withPadding(padding: EdgeInsets.all(07.sp)),
      ],
    );
  }
}

class TabbarCard extends StatelessWidget {
  final bool cardenable;
  final String label;
  const TabbarCard({super.key, required this.cardenable, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardenable ? commonColor : null,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: AppText.small(
        label,
        fontSize: 17,
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
