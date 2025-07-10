import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';

import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Bloc/bloc/payroll_bloc.dart';
import 'package:act/Features/HrManagement/Models/payroll_list_model.dart';
import 'package:act/Features/HrManagement/Screens/PayrollDetails/payroll_filter.dart';
import 'package:act/Features/Report/payroll_genrater_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PayrollDetails extends StatefulWidget {
  const PayrollDetails({super.key});

  @override
  State<PayrollDetails> createState() => _PayrollDetailsState();
}

class _PayrollDetailsState extends State<PayrollDetails> {
  String? searchvalue;
  @override
  void initState() {
    payrollBloc.add(PayrollListEvent());
    super.initState();
  }

  final PayrollBloc payrollBloc = PayrollBloc();

  @override
  Widget build(BuildContext context) {
    List<DataRow> getPayrollTableRows(
      PayrollListModel model, {
      String? employeeNameFilter,
    }) {
      // filter if employeeNameFilter is provided and not empty
      final filteredRecords =
          (employeeNameFilter != null && employeeNameFilter.isNotEmpty)
              ? model.payrollRecords
                  .where(
                    (payroll) => payroll.employeeName.toLowerCase().contains(
                      employeeNameFilter.toLowerCase(),
                    ),
                  )
                  .toList()
              : model.payrollRecords;

      return filteredRecords.map((payroll) {
        return DataRow(
          cells: [
            DataCell(Text(payroll.employeeId.toString())),
            DataCell(Text(payroll.employeeName)),
            DataCell(Text(payroll.department)),
            DataCell(Text(payroll.month)),
            DataCell(Text(payroll.netSalary.toStringAsFixed(2))),
            DataCell(Text(payroll.totalDays.toString())),
            // DataCell(Icon(Icons.edit, color: Colors.blue)),
          ],
        );
      }).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        payrollfilter(
          payrollBloc: payrollBloc,
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
            child: BlocConsumer<PayrollBloc, PayrollState>(
              bloc: payrollBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is PayrollDataState) {
                  return Column(
                    children: [
                      CustomTable(
                        datacolumns: [
                          'Id',
                          'Employee Name',
                          "Department",
                          "Month",
                          "Net Salary",
                          "Total Days",
                          // "Action",
                        ],
                        dataRow: getPayrollTableRows(
                          state.modelData,
                          employeeNameFilter: searchvalue,
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PayrollPdfScreen(
                                      payrollData: state.modelData,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            // height: 15.sp,
                            // width: 35.sp,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(07.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppText.small(
                                  "Payroll Report Generated",
                                  fontSize: 11.sp,
                                ).withPadding(padding: EdgeInsets.all(10.sp)),
                              ],
                            ),
                          ).withPadding(padding: EdgeInsets.all(10.sp)),
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
    ).withPadding(padding: EdgeInsets.all(07.sp));
  }
}
