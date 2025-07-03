import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:flutter/material.dart';

Future<void> showUpdateAttendanceDialog({
  required BuildContext context,
  required int recordId,

  required Function() onSuccess,
}) async {
  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;
  final TextEditingController workHoursController = TextEditingController();
  final TextEditingController overtimeHoursController = TextEditingController();

  bool presentOne = false;
  bool presentTwo = false;
  bool isOvertime = false;

  // final selectedDate = DateTime.now();
  // final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder:
        (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.indigo.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.edit_calendar_rounded,
                              color: Colors.indigo[600],
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Update Attendance',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                // SizedBox(height: 4),
                                // Text(
                                //   DateFormat(
                                //     'MMMM dd, yyyy',
                                //   ).format(selectedDate),
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.grey[600],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 28),

                      // Time Section
                      _buildSectionHeader('Time Details'),
                      SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTimePickerField(
                              context: context,
                              label: "Check-in",
                              icon: Icons.login_rounded,
                              selectedTime: checkInTime,
                              onTimeSelected:
                                  (time) => setState(() => checkInTime = time),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildTimePickerField(
                              context: context,
                              label: "Check-out",
                              icon: Icons.logout_rounded,
                              selectedTime: checkOutTime,
                              onTimeSelected:
                                  (time) => setState(() => checkOutTime = time),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Hours Section
                      _buildSectionHeader('Hours'),
                      SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              "Work Hours",
                              workHoursController,
                              Icons.access_time_rounded,
                              "8.5",
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              "Overtime Hours",
                              overtimeHoursController,
                              Icons.more_time_rounded,
                              "2.0",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Status Section
                      _buildSectionHeader('Status'),
                      SizedBox(height: 8),

                      _buildModernCheckbox(
                        "Present One",
                        presentOne,
                        Icons.check_circle_outline_rounded,
                        (val) => setState(() => presentOne = val),
                      ),

                      _buildModernCheckbox(
                        "Present Two",
                        presentTwo,
                        Icons.check_circle_outline_rounded,
                        (val) => setState(() => presentTwo = val),
                      ),

                      _buildModernCheckbox(
                        "Overtime",
                        isOvertime,
                        Icons.schedule_rounded,
                        (val) => setState(() => isOvertime = val),
                      ),

                      SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                foregroundColor: Colors.grey[600],
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  // Uncomment and use your API call
                                  HrRepository repository = HrRepository();
                                  final session = SessionManagerClass();

                                  session.getlicence().then((value) async {
                                    await repository
                                        .updateAttendanceById(
                                          licenseKey: value,
                                          checkInTime:
                                              checkInTime != null
                                                  ? _formatTimeOfDayToString(
                                                    checkInTime!,
                                                  )
                                                  : null,
                                          checkOutTime:
                                              checkOutTime != null
                                                  ? _formatTimeOfDayToString(
                                                    checkOutTime!,
                                                  )
                                                  : null,
                                          workHours:
                                              workHoursController.text
                                                      .trim()
                                                      .isEmpty
                                                  ? null
                                                  : workHoursController.text
                                                      .trim(),
                                          overtimeHours:
                                              overtimeHoursController.text
                                                      .trim()
                                                      .isEmpty
                                                  ? null
                                                  : overtimeHoursController.text
                                                      .trim(),
                                          presentOne: presentOne,
                                          presentTwo: presentTwo,
                                          isOvertime: isOvertime,
                                          attendanceId: recordId,
                                        )
                                        .whenComplete(() {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                          onSuccess();
                                        });
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Attendance updated successfully!',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.green[600],
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: EdgeInsets.all(16),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Error: $e',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.red[600],
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: EdgeInsets.all(16),
                                      duration: Duration(seconds: 4),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo[600],
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 4),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    ),
  );
}

Widget _buildTextField(
  String label,
  TextEditingController controller,
  IconData icon,
  String hint,
) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      hintStyle: TextStyle(color: Colors.grey[400]),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 16, right: 12),
        child: Icon(icon, color: Colors.grey[400], size: 20),
      ),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.indigo[400]!, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}

Widget _buildTimePickerField({
  required BuildContext context,
  required String label,
  required IconData icon,
  required TimeOfDay? selectedTime,
  required Function(TimeOfDay) onTimeSelected,
}) {
  return InkWell(
    onTap: () async {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) onTimeSelected(pickedTime);
    },
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  selectedTime != null
                      ? _formatTimeOfDayToDisplay(selectedTime)
                      : "Select time",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        selectedTime != null
                            ? Colors.grey[800]
                            : Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildModernCheckbox(
  String label,
  bool value,
  IconData icon,
  Function(bool) onChanged,
) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: value ? Colors.indigo[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value ? Colors.indigo[200]! : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value ? Colors.indigo[600] : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: value ? Colors.indigo[600]! : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child:
                  value
                      ? Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
            ),
            SizedBox(width: 12),
            Icon(
              icon,
              size: 18,
              color: value ? Colors.indigo[600] : Colors.grey[500],
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: value ? Colors.indigo[700] : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Correct time formatting functions
String _formatTimeOfDayToDisplay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

String _formatTimeOfDayToString(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute:00'; // HH:MM:SS format for backend
}
