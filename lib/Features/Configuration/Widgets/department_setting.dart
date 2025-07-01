import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Bloc/ConfigurationBloc/configuration_bloc.dart';
import 'package:act/Features/Configuration/Constants/configuration_constants.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DepartmentSetting extends StatelessWidget {
  const DepartmentSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationBloc configurationBloc = ConfigurationBloc();
    final ConfigurationRepo configurationRepo = ConfigurationRepo();
    List<DataRow> getDepartmentTableRows(DepartmentListModel departmentModel) {
      return departmentModel.departments?.map((department) {
            return DataRow(
              cells: [
                DataCell(Text(department.id?.toString() ?? "-")),
                DataCell(Text(department.departmentName ?? "-")),
                DataCell(
                  InkWell(
                    onTap: () {
                      showAddOrUpdateDesignationDialog(
                        title: "Department",
                        context: context,
                        id: department.id,
                        initialDesignation: department.departmentName,
                        onSubmit: (departmentName, id) {
                          if (id != null) {
                            configurationRepo
                                .updateDeparmentApi(id, departmentName)
                                .whenComplete(() {
                                  configurationBloc.add(ListDepartment());
                                });
                          }
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
            "Department Setting",
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
                    bloc: configurationBloc..add(ListDepartment()),
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is DepartmentListDataState) {
                        deparment = state.modelData;
                        return CustomTable(
                          datacolumns: ['ID', 'Depatment', 'Action'],
                          dataRow: getDepartmentTableRows(deparment),
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
                            title: "Depatment",
                            context: context,
                            onSubmit: (values, id) async {
                              final session = SessionManagerClass();
                              await session.getlicence().then((value) {
                                configurationRepo
                                    .addDeparmentApi(value, values)
                                    .whenComplete(() {
                                      configurationBloc.add(ListDepartment());
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
                            child: AppText.small("Add", fontSize: 11.sp),
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
