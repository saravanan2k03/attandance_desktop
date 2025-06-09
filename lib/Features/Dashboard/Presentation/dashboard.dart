import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_lower_widget.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_upper_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: CustomDrawer(dashboard: true)),
          Expanded(
            flex: 13,
            child: Column(children: [CustomAppbar(), DashboardCards()]),
          ),
        ],
      ),
    );
  }
}

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(flex: 5, child: HrDashboardUpperWidget()),
          // Expanded(
          //   flex: 2,
          //   child: Row(
          //     spacing: 07.sp,
          //     children: [
          //       HrDashboardMiddleCards(),
          //       HrDashboardMiddleCards(),
          //       HrDashboardMiddleCards(),
          //       HrDashboardMiddleCards(),
          //       HrDashboardMiddleCards(),
          //       HrDashboardMiddleCards(),
          //       HrDashboardMiddleCards(),
          //     ],
          //   ).withPadding(
          //     padding: EdgeInsets.only(right: 07.sp, bottom: 07.sp),
          //   ),
          // ),
          Expanded(flex: 5, child: HrDashboardLowerWidget()),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}

class HrDashboardMiddleCards extends StatelessWidget {
  const HrDashboardMiddleCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: cardsColors,
          borderRadius: BorderRadius.circular(07.sp),
        ),
      ),
    );
  }
}
