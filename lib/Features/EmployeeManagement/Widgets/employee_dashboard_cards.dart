import 'package:act/Core/Constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmployeeDashboardCards extends StatelessWidget {
  const EmployeeDashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardsColors,
        borderRadius: BorderRadius.circular(07.sp),
      ),
    );
  }
}
