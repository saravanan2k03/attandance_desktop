import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DesignationSetting extends StatelessWidget {
  const DesignationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataRow> getDesignationTableRows(
      DesingantionListModel designationModel,
    ) {
      return designationModel.designations?.map((designation) {
            return DataRow(
              cells: [
                DataCell(Text(designation.id?.toString() ?? "-")),
                DataCell(Text(designation.designationName ?? "-")),
                const DataCell(Text("Yes")),
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
            "Designation Setting",
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          07.sp.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomBorderTextForm(title: "Designation"),
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
                    datacolumns: ['ID', 'Designation', 'Active'],
                    dataRow: getDesignationTableRows(designation),
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
