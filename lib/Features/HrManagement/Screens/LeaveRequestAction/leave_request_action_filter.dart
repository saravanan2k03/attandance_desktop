import 'package:act/Core/Constants/constant.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_dropdown.dart';
import 'package:act/Features/HrManagement/Bloc/LeaveRequestResultBloc/leave_request_filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class LeaveRequestActionFilter extends StatefulWidget {
  final TextEditingController searchController;
  final LeaveRequestFilterBloc leaveRequestFilterBloc;
  final String searchvalue;
  final Function(String)? onChanged;
  const LeaveRequestActionFilter({
    super.key,
    required this.searchController,
    required this.leaveRequestFilterBloc,
    required this.searchvalue,
    this.onChanged,
  });

  @override
  State<LeaveRequestActionFilter> createState() =>
      _LeaveRequestActionFilterState();
}

class _LeaveRequestActionFilterState extends State<LeaveRequestActionFilter> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  // Added controller for search

  // Separate variables for each dropdown
  String? selectedleaveaction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 07.sp,
      runSpacing: 07.sp,
      children: [
        SizedBox(
          width: 40.sp,
          child: CustomTextFormField(
            title: "Search",
            initialValue: widget.searchvalue,
            enable: true,
            onChanged: widget.onChanged,
          ),
        ),
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
          child: MyDropdown(
            hintText: "Leave Action",
            dropDownMenu: leaveAction,
            selectedItem: selectedleaveaction, // Use separate variable
            onChanged: (value) {
              setState(() {
                selectedleaveaction = value;
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
                  // Clear all fields
                  selectedleaveaction = null;

                  widget.searchController.clear();
                  fromDateController.clear();
                  toDateController.clear();
                  widget.leaveRequestFilterBloc.add(
                    LeaveRequestFilterDataEvent(),
                  );
                });
              },
              child: Container(
                height: 18.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(07.sp),
                ),
                child: Center(child: AppText.small("Clear", fontSize: 11.sp)),
              ),
            ),
            07.width,
            InkWell(
              onTap: () {
                // Add your submit logic here
                print("Search: ${widget.searchController.text}");
                print("From: ${fromDateController.text}");
                print("To: ${toDateController.text}");
                print("Work Shift: $selectedleaveaction");
                widget.leaveRequestFilterBloc.add(
                  LeaveRequestFilterDataEvent(
                    startDate:
                        fromDateController.text.isNotEmpty
                            ? fromDateController.text
                            : null,
                    endDate:
                        toDateController.text.isNotEmpty
                            ? toDateController.text
                            : null,
                    status: selectedleaveaction,
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
                child: Center(child: AppText.small("Submit", fontSize: 11.sp)),
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
    widget.searchController.dispose();
    super.dispose();
  }
}
