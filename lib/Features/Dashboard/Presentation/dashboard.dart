import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Screens/loading_screen.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_lower_widget.dart';
import 'package:act/Features/Dashboard/Presentation/Widgets/hr_dashboard_upper_widget.dart';
import 'package:act/Features/HrManagement/Bloc/bloc/hrdashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    final HrdashboardBloc hrdashboardBloc = HrdashboardBloc();
    return Expanded(
      child: BlocConsumer<HrdashboardBloc, HrdashboardState>(
        bloc: hrdashboardBloc..add(HrDashboardDataEvent()),
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HrDashboardDataState) {
            var summary = state.modelData.summary;
            var monthlyattendancechart = state.modelData.monthlyAttendanceChart;
            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: HrDashboardUpperWidget(
                    totalEmployees: summary.totalEmployees.toString(),
                    employeesAbsentToday: summary.absentToday.toString(),
                    employeesPresentToday: summary.presentToday.toString(),
                    employeesonLeaveToday: summary.onLeaveToday.toString(),
                    monthlyAttendanceChart: monthlyattendancechart,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: HrDashboardLowerWidget(
                    activeDevicesLoggedIn:
                        summary.activeDevicesLoggedIn.toString(),
                    lateCheckinsToday: summary.lateCheckinsToday.toString(),
                    newJoinsThisMonth: summary.newJoinsThisMonth.toString(),
                    pendingLeaveRequests:
                        summary.pendingLeaveRequests.toString(),
                    employeeLeaveToday: state.modelData.employeesOnLeaveToday,
                  ),
                ),
              ],
            );
          } else if (state is HrDashboardLoadingState) {
            return LoadingScreen();
          } else {
            return Center(child: Text("No Data Found"));
          }
        },
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
