import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Bloc/AttendanceBloc/attendance_bloc.dart';
import 'package:act/Features/HrManagement/Models/attendance_list_model.dart';
import 'package:act/Features/HrManagement/Screens/AttendanceDetails/attendance_filter.dart';
import 'package:act/Features/HrManagement/Widgets/update_attendance_dialgue.dart';
import 'package:act/Features/Report/attendance_generated_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AttendanceDetailsCard extends StatefulWidget {
  const AttendanceDetailsCard({super.key});

  @override
  State<AttendanceDetailsCard> createState() => _AttendanceDetailsCardState();
}

class _AttendanceDetailsCardState extends State<AttendanceDetailsCard> {
  @override
  void initState() {
    attendanceBloc.add(AttendanceListEvent());
    super.initState();
  }

  final AttendanceBloc attendanceBloc = AttendanceBloc();
  final TextEditingController searchController = TextEditingController();
  String? searchvalue;
  @override
  Widget build(BuildContext context) {
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
                    onSuccess: () {
                      attendanceBloc.add(AttendanceListEvent());
                    },
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
          searchvalue: searchvalue ?? "",
          onChanged: (value) {
            setState(() {
              searchvalue = value;
            });
          },
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: commonColor,
              borderRadius: BorderRadius.circular(05.sp),
            ),
            child: BlocConsumer<AttendanceBloc, AttendanceState>(
              bloc: attendanceBloc,
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
                          searchQuery: searchvalue,
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AttendancePdfScreen(
                                      attendanceData: state.modelData,
                                      organizationName: "",
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            height: 15.sp,
                            width: 35.sp,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(07.sp),
                            ),
                            child: Center(
                              child: AppText.small(
                                "Payroll Generated",
                                fontSize: 11.sp,
                              ),
                            ),
                          ).withPadding(padding: EdgeInsets.all(07.sp)),
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
