import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Features/EmployeeManagement/Bloc/bloc/employee_bloc.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_dashboard.dart';
import 'package:act/Features/EmployeeManagement/Screens/EmployeeDetails/employee_info_card.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_upper_widget.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_dashboard_lower_widget.dart';
import 'package:act/Features/EmployeeManagement/Widgets/employee_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class EmployeeDetails extends StatefulWidget {
  final int employeeID;
  const EmployeeDetails({super.key, required this.employeeID});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  void changetabbar(
    bool employeeDashboard,
    bool employeeInformation,
    bool leaveRequest,
  ) {
    employeeDashboardvar = employeeDashboard;
    employeeInformationvar = employeeInformation;
    leaveRequestvar = leaveRequest;
  }

  final EmployeeBloc employee = EmployeeBloc();
  @override
  void initState() {
    employee.add(EmployeeDashboardEvent(widget.employeeID));
    employeeDashboardvar = true;
    employeeInformationvar = false;
    leaveRequestvar = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomDrawer(
              employeeManagement: true,
              employeeDetails: true,
            ),
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
                          // height: 35.sp,
                          width: calcSize(context).longestSide,
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.small(
                                    "Employee Management",
                                    fontSize: 11.sp,
                                  ),
                                  07.sp.width,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  07.sp.width,
                                  AppText.small(
                                    "Employee Details",
                                    fontSize: 11.sp,
                                  ),
                                ],
                              ),
                              AppText.medium(
                                "Employee Details",
                                fontSize: 11.sp,
                              ),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: EmployeeInfoCard(
                                  employeeId: widget.employeeID,
                                ),
                              ),
                              07.width,
                              Expanded(
                                flex: 10,
                                child: Container(
                                  height: calcSize(context).longestSide,
                                  width: calcSize(context).longestSide,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(07.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: cardsColors,
                                              borderRadius:
                                                  BorderRadius.circular(07.sp),
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      changetabbar(
                                                        employeeDashboardvar =
                                                            true,
                                                        employeeInformationvar =
                                                            false,
                                                        leaveRequestvar = false,
                                                      );
                                                    });
                                                  },

                                                  child: TabbarCard(
                                                    cardenable:
                                                        employeeDashboardvar,
                                                    label: "Employee Dashboard",
                                                  ),
                                                ),

                                                // InkWell(
                                                //   onTap: () {
                                                //     setState(() {
                                                //       changetabbar(
                                                //         employeeDashboardvar =
                                                //             false,
                                                //         employeeInformationvar =
                                                //             false,
                                                //         leaveRequestvar = true,
                                                //       );
                                                //     });
                                                //   },
                                                //   child: TabbarCard(
                                                //     cardenable: leaveRequestvar,
                                                //     label: "Leave Request",
                                                //   ),
                                                // ),
                                              ],
                                            ).withPadding(
                                              padding: EdgeInsets.all(07.sp),
                                            ),
                                          ).withPadding(
                                            padding: EdgeInsets.all(07.sp),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: true,
                                        child: Expanded(
                                          child: BlocConsumer<
                                            EmployeeBloc,
                                            EmployeeState
                                          >(
                                            bloc:
                                                employee..add(
                                                  EmployeeDashboardEvent(
                                                    widget.employeeID,
                                                  ),
                                                ),
                                            listener: (context, state) {},
                                            buildWhen:
                                                (previous, current) =>
                                                    current
                                                        is EmployeehrDashboardDatastate,
                                            builder: (context, state) {
                                              if (state
                                                  is EmployeehrDashboardDatastate) {
                                                var modelData = state.modelData;
                                                return EmployeeDashboard(
                                                  absentinThisMonth:
                                                      modelData
                                                          .absentInThisMonth
                                                          .toString(),
                                                  attendanceThisMonth:
                                                      modelData
                                                          .attendanceThisMonth
                                                          .toString(),
                                                  clockIn: modelData.punchIn,
                                                  lateLogins:
                                                      modelData.lateLogins
                                                          .toString(),
                                                  leavesTaken:
                                                      modelData.leavesTaken
                                                          .toString(),
                                                  monthlyAbsents:
                                                      modelData.pieChart.absent,
                                                  monthlyPresents:
                                                      modelData
                                                          .pieChart
                                                          .present,
                                                  overtimeWorking:
                                                      modelData.overtimeWorking
                                                          .toString(),
                                                  pendingLeaveRequests:
                                                      modelData
                                                          .pendingLeaveRequests
                                                          .toString(),
                                                  pieleavesTaken:
                                                      modelData.pieChart.leave,
                                                  punchOut: modelData.punchOut,
                                                  tableData:
                                                      modelData.tableData,
                                                );
                                              } else if (state
                                                  is EmployeeDetailLoadingState) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                return Center(
                                                  child: AppText.small(
                                                    "No Data Available!",
                                                  ),
                                                );
                                              }
                                            },
                                          ).withPadding(
                                            padding: EdgeInsets.all(07.sp),
                                          ),
                                        ),
                                        // child: EmployeeLeaveRequest(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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

class EmployeeDashboard extends StatelessWidget {
  final double monthlyAbsents;
  final double monthlyPresents;
  final double pieleavesTaken;
  final String attendanceThisMonth;
  final String leavesTaken;
  final String lateLogins;
  final String pendingLeaveRequests;
  final String absentinThisMonth;
  final String overtimeWorking;
  final String clockIn;
  final String punchOut;
  final List<AttendanceTableData> tableData;
  const EmployeeDashboard({
    super.key,
    required this.monthlyAbsents,
    required this.monthlyPresents,
    required this.pieleavesTaken,
    required this.attendanceThisMonth,
    required this.leavesTaken,
    required this.lateLogins,
    required this.pendingLeaveRequests,
    required this.absentinThisMonth,
    required this.overtimeWorking,
    required this.clockIn,
    required this.punchOut,
    required this.tableData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmployeeDashboardUpperWidget(
          attendanceThisMonth: attendanceThisMonth,
          lateLogins: lateLogins,
          leavesTaken: leavesTaken,
          monthlyAbsents: monthlyAbsents,
          monthlyPresents: monthlyPresents,
          pendingLeaveRequests: pendingLeaveRequests,
          pieleavesTaken: pieleavesTaken,
        ),
        EmployeeDashboardLowerWidget(
          absentinThisMonth: absentinThisMonth,
          clockIn: clockIn,
          overtimeWorking: overtimeWorking,
          punchOut: punchOut,
          tableData: tableData,
        ),
      ],
    );
  }
}
