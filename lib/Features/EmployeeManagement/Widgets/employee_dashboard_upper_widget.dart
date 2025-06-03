import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_cards.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeDashboardUpperWidget extends StatelessWidget {
  const EmployeeDashboardUpperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cardsColors,
                borderRadius: BorderRadius.circular(07.sp),
              ),
              child: Center(
                child: AppText.small("Chart Container", fontSize: 17),
              ),
            ).withPadding(padding: EdgeInsets.symmetric(vertical: 07.sp)),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: EmployeeDashboardCards().withPadding(
                          padding: EdgeInsets.only(
                            top: 07.sp,
                            left: 07.sp,
                            bottom: 07.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: cardsColors,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ).withPadding(padding: EdgeInsets.all(07.sp)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: cardsColors,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ).withPadding(
                          padding: EdgeInsets.only(left: 07.sp, bottom: 07.sp),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: cardsColors,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                        ).withPadding(
                          padding: EdgeInsets.only(
                            left: 07.sp,
                            bottom: 07.sp,
                            right: 07.sp,
                          ),
                        ),
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
