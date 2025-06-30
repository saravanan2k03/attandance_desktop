import 'package:act/Features/EmployeeManagement/Widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class FillingForm extends StatelessWidget {
  const FillingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calcSize(context).longestSide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Fill the Employee Name", fontSize: 18),
          Wrap(
            spacing: 10.sp,
            children: const [
              CustomBorderTextForm(),
              CustomBorderDropDownForm(),
            ],
          ).withPadding(padding: EdgeInsets.only(top: 07.sp, bottom: 07.sp)),
        ],
      ),
    );
  }
}

class CustomBorderTextForm extends StatelessWidget {
  final String? title;
  final bool? readOnly;
  final Function()? onTap;
  final String? initialValue;
  final Function(String)? onChanged;
  const CustomBorderTextForm({
    super.key,
    this.title,
    this.readOnly,
    this.onTap,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.sp,
      // decoration: BoxDecoration(
      //     border: Border.all(), borderRadius: BorderRadius.circular(07.sp)),
      child: CustomTextFormField(
        title: title ?? "",
        initialValue: initialValue ?? "",
        enable: true,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomBorderDropDownForm extends StatelessWidget {
  final String? hintText;
  final List<String>? dropDownMenu;
  final String? selectedItem;
  final Function(String?)? onChanged;
  const CustomBorderDropDownForm({
    super.key,
    this.hintText,
    this.dropDownMenu,
    this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MyDropdown(
      hintText: hintText,
      dropDownMenu: dropDownMenu,
      selectedItem: selectedItem,
      onChanged: onChanged,
    );
  }
}
