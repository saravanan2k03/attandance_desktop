import 'package:flutter/material.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:sizer/sizer.dart';

class TabbarCard extends StatelessWidget {
  final bool cardenable;
  final String label;
  const TabbarCard({super.key, required this.cardenable, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardenable ? Color(0xff2196f3) : null,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: AppText.small(
        label,
        fontSize: 11.sp,
        color: cardenable ? Colors.white : Colors.black,
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
