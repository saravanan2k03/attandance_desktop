import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23.sp,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              CircleAvatar(
                child: Center(child: Icon(Icons.notifications_rounded)),
              ),
              10.width,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Row(
                  children: [
                    AppText.small("Admin", fontSize: 17),
                    07.width,
                    CircleAvatar(),
                  ],
                ).withPadding(padding: EdgeInsets.all(07.sp)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
