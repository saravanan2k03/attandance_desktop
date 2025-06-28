import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Bloc/LeaveRequestResultBloc/leave_request_filter_bloc.dart';
import 'package:act/Features/HrManagement/Models/leave_request_filter_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:act/Features/HrManagement/Screens/LeaveRequestAction/leave_request_action_filter.dart';
import 'package:act/Features/HrManagement/Widgets/aprove_or_reject_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LeaveRequestAction extends StatelessWidget {
  const LeaveRequestAction({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveRequestFilterBloc leaveRequestFilterBloc =
        LeaveRequestFilterBloc();
    final TextEditingController searchController = TextEditingController();
    final HrRepository hrRepo = HrRepository();
    List<DataRow> buildLeaveDataRows(
      List<LeaveRequest> leaveRequests, {
      String searchQuery = '',
    }) {
      return leaveRequests
          .where(
            (leave) => leave.employeeName.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
          )
          .map(
            (leave) => DataRow(
              cells: [
                DataCell(Text(leave.id.toString())),
                DataCell(Text(leave.employeeName)),
                DataCell(Text(leave.leaveType)),
                DataCell(Text(leave.startDate)),
                DataCell(Text(leave.endDate)),
                DataCell(Text(leave.status)),
                DataCell(
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => LeaveStatusDialog(
                              leaveId: leave.id,
                              onSubmit: ({
                                required int leaveId,
                                required String action,
                              }) async {
                                await hrRepo.approveOrRejectLeave(
                                  leaveId: leaveId,
                                  action: action,
                                );
                              },
                            ),
                      );
                      leaveRequestFilterBloc.add(LeaveRequestFilterDataEvent());
                    },
                    child: Icon(Icons.edit, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveRequestActionFilter(
          searchController: searchController,
          leaveRequestFilterBloc: leaveRequestFilterBloc,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: commonColor,
              borderRadius: BorderRadius.circular(05.sp),
            ),
            child:
                BlocConsumer<LeaveRequestFilterBloc, LeaveRequestFilterState>(
                  bloc:
                      leaveRequestFilterBloc
                        ..add(LeaveRequestFilterDataEvent()),
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LeaveRequestFilterData) {
                      return Column(
                        children: [
                          CustomTable(
                            datacolumns: [
                              'Id',
                              'Employee Name',
                              "Leave Type",
                              "Start Date",
                              "End Date",
                              "Status",
                              "Action",
                            ],
                            dataRow: buildLeaveDataRows(
                              state.modelData.leaveRequests,
                              searchQuery: searchController.text,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: AppText.small("No Data Available!"));
                    }
                  },
                ),
          ).withPadding(padding: EdgeInsets.all(07.sp)),
        ),
        // 07.height,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Container(
        //       height: 17.sp,
        //       width: 30.sp,
        //       decoration: BoxDecoration(
        //         color: Colors.amber,
        //         borderRadius: BorderRadius.circular(07.sp),
        //       ),
        //       child: Center(child: AppText.small("Prev", fontSize: 11.sp)),
        //     ),
        //     10.width,
        //     Container(
        //       height: 17.sp,
        //       width: 30.sp,
        //       decoration: BoxDecoration(
        //         color: Colors.amber,
        //         borderRadius: BorderRadius.circular(07.sp),
        //       ),
        //       child: Center(child: AppText.small("Next", fontSize: 11.sp)),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
