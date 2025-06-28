import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:act/Features/HrManagement/Models/attendance_list_model.dart';
import 'package:act/Features/HrManagement/Screens/AttendanceDetails/attendance_filter.dart';
import 'package:act/Features/HrManagement/Widgets/update_attendance_dialgue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AttendanceDetailsCard extends StatelessWidget {
  const AttendanceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceBloc attendanceBloc = AttendanceBloc();
    final TextEditingController searchController = TextEditingController();
    List<DataRow> buildAttendanceDataRows(
      List<AttendanceRecord> records, {
      String? searchQuery,
    }) {
      final filteredRecords =
          (searchQuery == null || searchQuery.isEmpty)
              ? records
              : records
                  .where(
                    (record) => record.employeeName.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ),
                  )
                  .toList();

      return filteredRecords.map((record) {
        return DataRow(
          cells: [
            DataCell(Text(record.attendanceId.toString())),
            DataCell(Text(record.employeeName)),
            DataCell(Text(record.checkIn)),
            DataCell(Text(record.checkOut)),
            DataCell(Text(record.date)),
            DataCell(
              InkWell(
                onTap: () {
                  showUpdateAttendanceDialog(
                    context: context,
                    recordId: record.attendanceId,
                    onSuccess: () {},
                  );
                },
                child: Icon(Icons.edit, color: Colors.black),
              ),
            ),
          ],
        );
      }).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AttendanceFilter(
          searchController: searchController,
          attendanceBloc: attendanceBloc,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: commonColor,
              borderRadius: BorderRadius.circular(05.sp),
            ),
            child: BlocConsumer<AttendanceBloc, AttendanceState>(
              bloc: attendanceBloc..add(AttendanceListEvent()),
              listener: (context, state) {},
              builder: (context, state) {
                if (state is AttendanceDataState) {
                  return Column(
                    children: [
                      CustomTable(
                        datacolumns: [
                          'Id',
                          'Employee Name',
                          "Check In",
                          "Check Out",
                          "Date",
                          "Action",
                        ],
                        dataRow: buildAttendanceDataRows(
                          state.modelData.records,
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
          ),
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
