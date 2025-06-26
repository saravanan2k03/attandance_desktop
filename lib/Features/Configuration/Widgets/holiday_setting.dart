import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Models/holiday_list_model.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HolidaySetting extends StatelessWidget {
  const HolidaySetting({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataRow> getHolidayTableRows(HolidayListModel holidayModel) {
      return holidayModel.leaves?.map((holiday) {
            return DataRow(
              cells: [
                DataCell(Text(holiday.id?.toString() ?? "-")),
                DataCell(Text(holiday.leaveName ?? "-")),
                DataCell(Text((holiday.isActive ?? false) ? "Yes" : "No")),
              ],
            );
          }).toList() ??
          [];
    }

    TextEditingController toDateController = TextEditingController();
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
          Row(children: [CustomBorderTextForm(title: "Holiday Name")]),
          07.sp.height,
          Row(
            children: [
              SizedBox(
                width: 50.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Date",
                  controller: toDateController,
                  readOnly: true,
                  onTap: () {
                    selectDate(context).then((value) {
                      toDateController.text = value;
                    });
                  },
                ),
              ),
            ],
          ),
          07.sp.height,
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close),
                ),
              ),
              07.width,
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.check),
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
                    datacolumns: ['ID', 'Holiday Name', 'Active'],
                    dataRow: getHolidayTableRows(holidaylist),
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
