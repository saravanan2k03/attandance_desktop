import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Models/configuration_list_model.dart';
import 'package:act/Features/Configuration/Widgets/configuration_setting.dart';
import 'package:act/Features/Configuration/Widgets/department_setting.dart';
import 'package:act/Features/Configuration/Widgets/designation_setting.dart';
import 'package:act/Features/Configuration/Widgets/holiday_setting.dart';
import 'package:act/Features/Configuration/Widgets/leave_type_setting.dart';
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
  TextEditingController punchInStartLateTimeController =
      TextEditingController();
  TextEditingController punchInEndLateTime = TextEditingController();
  TextEditingController punchOutStartTime = TextEditingController();
  TextEditingController punchOutEndTime = TextEditingController();
  TextEditingController overTimeWorkingEndTime = TextEditingController();

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
                        ConfigurationSetting(
                          punchInStartTimeController:
                              punchInStartTimeController,
                          punchInEndTimeController: punchInEndTimeController,
                          overTimeWorkingEndTime: overTimeWorkingEndTime,
                          punchInEndLateTime: punchInEndLateTime,
                          punchInStartLateTimeController:
                              punchInStartLateTimeController,
                          punchOutEndTime: punchOutEndTime,
                          punchOutStartTime: punchOutStartTime,
                        ),
                        DesignationSetting(),
                        DepartmentSetting(),
                        LeaveTypeSetting(),
                        HolidaySetting(),
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
