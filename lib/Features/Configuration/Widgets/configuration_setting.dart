import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Bloc/ConfigurationBloc/configuration_bloc.dart';
import 'package:act/Features/Configuration/Models/configuration_list_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ConfigurationSetting extends StatelessWidget {
  ConfigurationSetting({
    super.key,
    required this.punchInStartTimeController,
    required this.punchInEndTimeController,
    required this.punchInStartLateTimeController,
    required this.punchInEndLateTime,
    required this.punchOutStartTime,
    required this.punchOutEndTime,
    required this.overTimeWorkingEndTime,
  });

  final TextEditingController punchInStartTimeController;
  final TextEditingController punchInEndTimeController;
  final TextEditingController punchInStartLateTimeController;
  final TextEditingController punchInEndLateTime;
  final TextEditingController punchOutStartTime;
  final TextEditingController punchOutEndTime;
  final TextEditingController overTimeWorkingEndTime;
  String? workshiftvar;
  void populateConfigurationControllers(Configurations? config) {
    punchInStartTimeController.text = config?.punchInStartTime ?? '';
    punchInEndTimeController.text = config?.punchInEndTime ?? '';
    punchInStartLateTimeController.text = config?.punchInStartLateTime ?? '';
    punchInEndLateTime.text = config?.punchInEndLateTime ?? '';
    punchOutStartTime.text = config?.punchOutStartTime ?? '';
    punchOutEndTime.text = config?.punchOutEndTime ?? '';
    overTimeWorkingEndTime.text = config?.overTimeWorkingEndTime ?? '';

    // Set workshift, keep existing value if null
    workshiftvar = config?.workshift ?? workshiftvar ?? '';
  }

  final ConfigurationBloc configurationBloc = ConfigurationBloc();
  final ConfigurationRepo configurationRepo = ConfigurationRepo();
  @override
  Widget build(BuildContext context) {
    return Container(
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
          AppText.medium(
            "Configuration Settings",
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          BlocConsumer<ConfigurationBloc, ConfigurationState>(
            bloc: configurationBloc..add(ConfigurationSettingEventFetch()),
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ConfigurationDataState) {
                final configs = state.modelData.configurations ?? [];
                // if (configs.isEmpty) {
                //   return Center(
                //     child: AppText.small("No Configurations Found!"),
                //   );
                // }
                populateConfigurationControllers(
                  configs.isNotEmpty ? configs.first : null,
                );
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height, // spacing
                      CustomBorderDropDownForm(
                        hintText: "Work shift",
                        dropDownMenu: workShift,
                        selectedItem: workshiftvar,
                        onChanged: (value) {
                          workshiftvar = value!;
                          configurationBloc.add(
                            ConfigurationSettingEventFetch(
                              workshift: workshiftvar,
                            ),
                          );
                        },
                      ),
                      10.height, // spacing
                      CustomTextFormFieldwithcontroller(
                        title: "Punch In Start Time",
                        controller: punchInStartTimeController,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          punchInStartTimeController.text = selectedTime;
                        },
                      ),

                      10.height,

                      CustomTextFormFieldwithcontroller(
                        title: "Punch In End Time",
                        controller: punchInEndTimeController,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          punchInEndTimeController.text = selectedTime;
                        },
                      ),
                      10.height,

                      CustomTextFormFieldwithcontroller(
                        title: "Punch In Start Late Time",
                        controller: punchInStartLateTimeController,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          punchInStartLateTimeController.text = selectedTime;
                        },
                      ),
                      10.height,

                      CustomTextFormFieldwithcontroller(
                        title: "Punch In End Late Time",
                        controller: punchInEndLateTime,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          punchInEndLateTime.text = selectedTime;
                        },
                      ),
                      10.height,

                      CustomTextFormFieldwithcontroller(
                        title: "Punch Out Start Time",
                        controller: punchOutStartTime,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          punchOutStartTime.text = selectedTime;
                        },
                      ),
                      10.height,

                      CustomTextFormFieldwithcontroller(
                        title: "Punch Out End Time",
                        controller: punchOutEndTime,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          punchOutEndTime.text = selectedTime;
                        },
                      ),
                      10.height,

                      CustomTextFormFieldwithcontroller(
                        title: "Over Time Working End Time",
                        controller: overTimeWorkingEndTime,
                        readOnly: true,
                        onTap: () async {
                          final selectedTime = await selectTime(context);
                          overTimeWorkingEndTime.text = selectedTime;
                        },
                      ),
                      10.height,
                    ],
                  ),
                );
              } else if (state is ConfigurationLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: AppText.small("No Data Available!"));
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  configurationBloc.add(ConfigurationSettingEventFetch());
                },
                child: Container(
                  height: 18.sp,
                  width: 40.sp,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(07.sp),
                  ),
                  child: Center(child: AppText.small("Reset", fontSize: 11.sp)),
                ),
              ),
              07.width,
              InkWell(
                onTap: () {
                  getuserType().whenComplete(() {
                    configurationRepo
                        .addOrUpdateConfig(
                          licenseKey: globallicenseKey,
                          workshift: workshiftvar ?? "",
                          punchInStartTime: punchInStartTimeController.text,
                          punchInEndTime: punchInEndTimeController.text,
                          punchInStartLateTime:
                              punchInStartLateTimeController.text,
                          punchInEndLateTime: punchInEndLateTime.text,
                          punchOutStartTime: punchOutStartTime.text,
                          punchOutEndTime: punchOutEndTime.text,
                          overTimeWorkingEndTime: overTimeWorkingEndTime.text,
                        )
                        .whenComplete(() {
                          configurationBloc.add(
                            ConfigurationSettingEventFetch(
                              workshift: workshiftvar,
                            ),
                          );
                        });
                  });
                },
                child: Container(
                  height: 18.sp,
                  width: 40.sp,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(07.sp),
                  ),
                  child: Center(
                    child: AppText.small("Submit", fontSize: 11.sp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
