import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Widgets/filling_form.dart';
import 'package:act/Features/HrManagement/Bloc/bloc/payroll_bloc.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class payrollfilter extends StatefulWidget {
  final PayrollBloc payrollBloc;
  const payrollfilter({super.key, required this.payrollBloc});

  @override
  State<payrollfilter> createState() => _payrollfilterState();
}

class _payrollfilterState extends State<payrollfilter> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  String? selectedDepartmentName;
  int? selectedDepartmentId;
  String? selectedWorkShift;

  final activeDepartments =
      deparment.departments!.where((e) => e.isActive == true).toList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(width: 40.sp, child: CustomBorderTextForm(title: "Search")),
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "From",
            controller: fromDateController,
            readOnly: true,
            onTap: () {
              selectDate(context).then((value) {
                fromDateController.text = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomTextFormFieldwithcontroller(
            title: "To",
            controller: toDateController,
            readOnly: true,
            onTap: () {
              selectDate(context).then((value) {
                toDateController.text = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Work shift",
            dropDownMenu: workShift,
            selectedItem: selectedWorkShift,
            onChanged: (value) {
              setState(() {
                selectedWorkShift = value;
              });
            },
          ),
        ),
        SizedBox(
          width: 40.sp,
          child: CustomBorderDropDownForm(
            hintText: "Department",
            dropDownMenu:
                activeDepartments.map((e) => e.departmentName ?? "").toList(),
            selectedItem: selectedDepartmentName,
            onChanged: (value) {
              setState(() {
                selectedDepartmentName = value;
                selectedDepartmentId =
                    activeDepartments
                        .firstWhere((dept) => dept.departmentName == value)
                        .id;
              });
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  fromDateController.clear();
                  toDateController.clear();
                  selectedDepartmentName = null;
                  selectedDepartmentId = null;
                  selectedWorkShift = null;
                  widget.payrollBloc.add(PayrollListEvent());
                });
              },
              child: Container(
                height: 18.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Clear", fontSize: 17)),
              ),
            ),
            07.width,
            InkWell(
              onTap: () {
                widget.payrollBloc.add(
                  PayrollListEvent(
                    fromDate:
                        fromDateController.text.isNotEmpty == true
                            ? fromDateController.text
                            : null,
                    toDate:
                        toDateController.text.isNotEmpty == true
                            ? toDateController.text
                            : null,
                    workShift: selectedWorkShift,
                    departmentId: selectedDepartmentId,
                  ),
                );
              },
              child: Container(
                height: 18.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Submit", fontSize: 17)),
              ),
            ),
            07.width,
            InkWell(
              onTap: () {
                final payrollRepo = HrRepository();
                final session = SessionManagerClass();
                session
                    .getlicence()
                    .then((value) async {
                      await payrollRepo.generateOrUpdatePayroll(
                        licenseKey: value,
                      );
                    })
                    .whenComplete(() {
                      setState(() {
                        fromDateController.clear();
                        toDateController.clear();
                        selectedDepartmentName = null;
                        selectedDepartmentId = null;
                        selectedWorkShift = null;
                        widget.payrollBloc.add(PayrollListEvent());
                      });
                    });
              },
              child: Container(
                height: 18.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(
                  child: AppText.small("Generate Payroll", fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ],
    ).withPadding(padding: EdgeInsets.all(07.sp));
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }
}
