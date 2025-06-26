import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DepartmentSetting extends StatelessWidget {
  const DepartmentSetting({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataRow> getDepartmentTableRows(DepartmentListModel departmentModel) {
      return departmentModel.departments?.map((department) {
            return DataRow(
              cells: [
                DataCell(Text(department.id?.toString() ?? "-")),
                DataCell(Text(department.departmentName ?? "-")),
                DataCell(Text((department.isActive ?? false) ? "Yes" : "No")),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomBorderTextForm(title: "Department"),
              07.sp.width,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                  07.width,
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
          07.height,
          Expanded(
            child: Container(
              color: commonColor,
              child: Column(
                children: [
                  CustomTable(
                    datacolumns: ['ID', 'Department', 'Active'],
                    dataRow: getDepartmentTableRows(deparment),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
