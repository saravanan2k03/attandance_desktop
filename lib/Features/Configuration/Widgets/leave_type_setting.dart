import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Bloc/ConfigurationBloc/configuration_bloc.dart';
import 'package:act/Features/Configuration/Constants/configuration_constants.dart';
import 'package:act/Features/Configuration/Models/leave_type_list_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LeaveTypeSetting extends StatelessWidget {
  const LeaveTypeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationBloc configurationBloc = ConfigurationBloc();
    final ConfigurationRepo configurationRepo = ConfigurationRepo();
    List<DataRow> getLeavetyprTableRows(LeaveTypeListModel leavetypemodel) {
      return leavetypemodel.leaveTypes?.map((leavetype) {
            return DataRow(
              cells: [
                DataCell(Text(leavetype.id?.toString() ?? "-")),
                DataCell(Text(leavetype.leaveType ?? "-")),
                DataCell(
                  InkWell(
                    onTap: () {
                      showAddOrUpdateDesignationDialog(
                        title: "Leave Type",
                        context: context,
                        id: leavetype.id,
                        initialDesignation: leavetype.leaveType,
                        onSubmit: (designationName, id) async {
                          if (id != null) {
                            final session = SessionManagerClass();
                            await session.getlicence().then((value) {
                              configurationRepo
                                  .addOrUpdateLeaveType(
                                    isActive: true,
                                    leaveType: designationName,
                                    licenseKey: value,
                                    id: leavetype.id,
                                  )
                                  .whenComplete(() {
                                    configurationBloc.add(Listleavetype());
                                  });
                            });
                          }
                        },
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.black),
                  ),
                ),
                // DataCell(
                //   InkWell(
                //     onTap: () {
                //       showDeleteConfirmation(
                //         context: context,
                //         title: "Designation",
                //         name: designation.designationName ?? "",
                //         onConfirm: () {},
                //       );
                //     },
                //     child: Icon(Icons.delete, color: Colors.red),
                //   ),
                // ),
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
            "Leave Type Setting",
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
                    bloc: configurationBloc..add(Listleavetype()),
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is LeaveTypeListDataState) {
                        leaveTypeListModel = state.modelData;
                        return CustomTable(
                          datacolumns: ['ID', 'Leave Type', 'Action'],
                          dataRow: getLeavetyprTableRows(leaveTypeListModel),
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
                          showAddOrUpdateDesignationDialog(
                            title: "Leave Type",
                            context: context,
                            onSubmit: (designationName, id) async {
                              final session = SessionManagerClass();
                              await session.getlicence().then((value) {
                                configurationRepo
                                    .addOrUpdateLeaveType(
                                      isActive: true,
                                      leaveType: designationName,
                                      licenseKey: value,
                                    )
                                    .whenComplete(() {
                                      configurationBloc.add(Listleavetype());
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
