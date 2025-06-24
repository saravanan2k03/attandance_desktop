import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConfiugrationPage extends StatefulWidget {
  const ConfiugrationPage({super.key});

  @override
  State<ConfiugrationPage> createState() => _ConfiugrationPageState();
}

class _ConfiugrationPageState extends State<ConfiugrationPage> {
  TextEditingController punchInStartTimeController = TextEditingController();
  TextEditingController punchInEndTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: CustomDrawer(configuration: true)),
          Expanded(
            flex: 13,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.center,
                      spacing: 07.sp,
                      runSpacing: 07.sp,
                      children: [
                        Container(
                          height: 70.sp,
                          width: 60.sp,
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: cardsColors,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.medium(
                                    "Configuration Settings",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  10.height, // spacing
                                  CustomBorderDropDownForm(
                                    hintText: "Work shift",
                                  ),
                                  10.height, // spacing
                                  CustomTextFormFieldwithcontroller(
                                    title: "Punch In Start Time",
                                    controller: punchInStartTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInStartTimeController.text =
                                          selectedTime;
                                    },
                                  ),

                                  10.height,

                                  CustomTextFormFieldwithcontroller(
                                    title: "Punch In End Time",
                                    controller: punchInEndTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInEndTimeController.text =
                                          selectedTime;
                                    },
                                  ),
                                  10.height,

                                  CustomTextFormFieldwithcontroller(
                                    title: "Punch In Start Late Time",
                                    controller: punchInEndTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInEndTimeController.text =
                                          selectedTime;
                                    },
                                  ),
                                  10.height,

                                  CustomTextFormFieldwithcontroller(
                                    title: "Punch In End Late Time",
                                    controller: punchInEndTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInEndTimeController.text =
                                          selectedTime;
                                    },
                                  ),
                                  10.height,

                                  CustomTextFormFieldwithcontroller(
                                    title: "Punch Out Start Time",
                                    controller: punchInEndTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInEndTimeController.text =
                                          selectedTime;
                                    },
                                  ),
                                  10.height,

                                  CustomTextFormFieldwithcontroller(
                                    title: "Punch Out End Time",
                                    controller: punchInEndTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInEndTimeController.text =
                                          selectedTime;
                                    },
                                  ),
                                  10.height,

                                  CustomTextFormFieldwithcontroller(
                                    title: "Over Time Working End Time",
                                    controller: punchInEndTimeController,
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedTime = await selectTime(
                                        context,
                                      );
                                      punchInEndTimeController.text =
                                          selectedTime;
                                    },
                                  ),
                                  10.height,
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 18.sp,
                                    width: 40.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(
                                        07.sp,
                                      ),
                                    ),
                                    child: Center(
                                      child: AppText.small(
                                        "Clear",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  07.width,
                                  Container(
                                    height: 18.sp,
                                    width: 40.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(
                                        07.sp,
                                      ),
                                    ),
                                    child: Center(
                                      child: AppText.small(
                                        "Submit",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                            ],
                          ),
                        ),
                        Container(
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
                            ],
                          ),
                        ),
                        Container(
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
                            ],
                          ),
                        ),
                        Container(
                          height: 70.sp,
                          width: 60.sp,
                          decoration: BoxDecoration(color: cardsColors),
                          child: Column(
                            children: [
                              AppText.medium(
                                "Holidays Setting",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).withPadding(padding: EdgeInsets.all(07.sp)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
