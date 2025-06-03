import 'package:act/Core/Constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';

class EmployeeBasicCards extends StatelessWidget {
  final String label;
  final String data;
  final IconData customIcon;
  const EmployeeBasicCards({
    super.key,
    required this.label,
    required this.data,
    required this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: cardsColors,
            borderRadius: BorderRadius.circular(05.sp),
          ),
          child: Icon(
            customIcon,
            color: Colors.black,
          ).withPadding(padding: EdgeInsets.all(07.sp)),
        ),
        10.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium(
                data,
                textOverflow: TextOverflow.ellipsis,
                fontSize: 15,
              ),
              AppText.small(
                label,
                textOverflow: TextOverflow.ellipsis,
                fontSize: 17,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
