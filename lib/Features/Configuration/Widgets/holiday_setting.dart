import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Bloc/ConfigurationBloc/configuration_bloc.dart';
import 'package:act/Features/Configuration/Constants/configuration_constants.dart';
import 'package:act/Features/Configuration/Models/holiday_list_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HolidaySetting extends StatelessWidget {
  const HolidaySetting({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationBloc configurationBloc = ConfigurationBloc();
    final ConfigurationRepo configurationRepo = ConfigurationRepo();
    List<DataRow> getHolidayTableRows(HolidayListModel holidayModel) {
      return holidayModel.leaves?.map((holiday) {
            return DataRow(
              cells: [
                DataCell(Text(holiday.id?.toString() ?? "-")),
                DataCell(Text(holiday.leaveName ?? "-")),
                DataCell(
                  InkWell(
                    onTap: () {
                      DateTime? initialDate;
                      if (holiday.leaveDate != null) {
                        initialDate = DateTime.tryParse(holiday.leaveDate!);
                      }
                      showAddOrUpdateWithDateDialog(
                        context: context,
                        title: "Holiday",
                        initialDate: initialDate,
                        initialValue: holiday.leaveName,
                        onSubmit: (leavevalue, date) async {
                          final session = SessionManagerClass();
                          await session.getlicence().then((value) {
                            configurationRepo
                                .addOrUpdateHoliday(
                                  leaveDate: DateFormat(
                                    "yyyy-MM-dd",
                                  ).format(date),
                                  leaveName: leavevalue,
                                  id: holiday.id,

                                  licenseKey: value,
                                  isActive: true,
                                )
                                .whenComplete(() {
                                  configurationBloc.add(ListHoliday());
                                });
                          });
                        },
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.black),
                  ),
                ),
              ],
            );
          }).toList() ??
          [];
    }

    return Container(
      height: 70.sp,
      width: 60.sp,
      decoration: BoxDecoration(color: cardsColors),
      child: Column(
        children: [
          AppText.medium(
            "Holiday Setting",
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          07.sp.height,
          Expanded(
            child: Container(
              color: commonColor,
              child: Column(
                children: [
                  BlocConsumer<ConfigurationBloc, ConfigurationState>(
                    bloc: configurationBloc..add(ListHoliday()),
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is HolidayListDataState) {
                        holidaylist = state.modelData;
                        return CustomTable(
                          datacolumns: ['ID', 'Holiday', 'Action'],
                          dataRow: getHolidayTableRows(holidaylist),
                        );
                      } else {
                        return Center(child: Text("No Data Available!"));
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // showAddOrUpdateDesignationDialog(
                          //   title: "Designation",
                          //   context: context,
                          //   onSubmit: (designationName, id) async {
                          //     final session = SessionManagerClass();
                          // await session.getlicence().then((value) {
                          //   configurationRepo
                          //       .addDesignation(designationName, value)
                          //       .whenComplete(() {
                          //         configurationBloc.add(ListDesignation());
                          //       });
                          // });
                          //   },
                          // );

                          showAddOrUpdateWithDateDialog(
                            context: context,
                            title: "Holiday",
                            onSubmit: (leavevalue, date) async {
                              final session = SessionManagerClass();
                              await session.getlicence().then((value) {
                                configurationRepo
                                    .addOrUpdateHoliday(
                                      leaveDate: DateFormat(
                                        "yyyy-MM-dd",
                                      ).format(date),
                                      leaveName: leavevalue,
                                      licenseKey: value,
                                      isActive: true,
                                    )
                                    .whenComplete(() {
                                      configurationBloc.add(ListHoliday());
                                    });
                              });
                            },
                          );
                        },
                        child: Container(
                          height: 18.sp,
                          width: 40.sp,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                          child: Center(
                            child: AppText.small("Add", fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ).withPadding(padding: EdgeInsets.all(07.sp)),
            ),
          ),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
