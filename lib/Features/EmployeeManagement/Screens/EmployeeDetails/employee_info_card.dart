import 'package:act/Features/EmployeeManagement/Widgets/employee_basic_cards.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class EmployeeInfoCard extends StatelessWidget {
  const EmployeeInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: Column(
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
                      "Saravanan",
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 18,
                    ),
                    AppText.small(
                      "Software Developer",
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 18,
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
                      AppText.medium("Personal Info", fontSize: 18),
                      const EmployeeBasicCards(
                        label: "Nationality",
                        data: "XXXXXXXXXXX",
                        customIcon: Icons.flag,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Gender",
                        data: "Male",
                        customIcon: Icons.wc,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Department",
                        data: "Technical",
                        customIcon: Icons.apartment,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Work Shift",
                        data: "Morning",
                        customIcon: Icons.schedule,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Date Of Birth",
                        data: "13-09-2003",
                        customIcon: Icons.cake,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Basic Salary",
                        data: "70,00,000",
                        customIcon: Icons.attach_money,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "User Name",
                        data: "Saro2k",
                        customIcon: Icons.person,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Gosi Applicable",
                        data: "Applicable",
                        customIcon: Icons.verified_user,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                    ],
                  ),
                  10.height,
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.medium("Contact Info", fontSize: 18),
                      const EmployeeBasicCards(
                        label: "Mobile no",
                        data: "7010036887",
                        customIcon: Icons.phone,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Iqma number",
                        data: "7010036887",
                        customIcon: Icons.badge,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "Email Id",
                        data: "helo@gamil.com",
                        customIcon: Icons.email,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                      const EmployeeBasicCards(
                        label: "User type",
                        data: "Employee",
                        customIcon: Icons.supervised_user_circle,
                      ).withPadding(padding: EdgeInsets.only(top: 07.sp)),
                    ],
                  ),
                ],
              ).withPadding(padding: EdgeInsets.only(bottom: 10.sp)),
            ),
          ),
        ],
      ).withPadding(padding: EdgeInsets.symmetric(horizontal: 07.sp)),
    );
  }
}
