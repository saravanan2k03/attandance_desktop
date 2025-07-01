import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';

class EmployeePersonalDetails extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileNoController;
  final TextEditingController dateOfBirthController;
  final TextEditingController joiningDateController;
  final ValueNotifier<String?> genderController;
  final TextEditingController emailIdController;
  final TextEditingController nationalityController;
  final TextEditingController iqamaNumberController;
  const EmployeePersonalDetails({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileNoController,
    required this.dateOfBirthController,
    required this.joiningDateController,
    required this.genderController,
    required this.emailIdController,
    required this.nationalityController,
    required this.iqamaNumberController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calcSize(context).longestSide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.medium("Employee Personal Details", fontSize: 11.sp),
          10.height,
          Wrap(
            spacing: 10.sp,
            runSpacing: 10.sp,
            children: [
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "First Name",
                  controller: firstNameController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Last Name",
                  controller: lastNameController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Mobile No",
                  controller: mobileNoController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Date of Birth",
                  controller: dateOfBirthController,
                  onTap: () async {
                    final selectedDate = await selectDate(context);
                    dateOfBirthController.text = selectedDate;
                    log(selectedDate);
                  },
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Joining Date",
                  controller: joiningDateController,
                  onTap: () async {
                    final selectedDate = await selectDate(context);
                    joiningDateController.text = selectedDate;
                    log(selectedDate);
                  },
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomBorderDropDownForm(
                  hintText: "Gender",
                  dropDownMenu: gender,
                  selectedItem: genderController.value,
                  onChanged: (value) {
                    genderController.value = value!;
                  },
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Email id",
                  controller: emailIdController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Nationality",
                  controller: nationalityController,
                ),
              ),
              SizedBox(
                width: 40.sp,
                child: CustomTextFormFieldwithcontroller(
                  title: "Iqama number",
                  controller: iqamaNumberController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
