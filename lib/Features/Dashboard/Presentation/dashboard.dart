import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: CustomDrawer()),
          Expanded(
            flex: 13,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(child: Container(color: Colors.blueGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.sp,
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Container(color: Colors.blueAccent)),
          Row(
            spacing: 07.sp,
            children: [CircleAvatar(), CircleAvatar(), CircleAvatar()],
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Container(
            height: 23.sp,
            width: MediaQuery.of(context).size.longestSide,
            color: Colors.amber,
          ),
          07.sp.height,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 07.sp,
                children: [
                  Container(
                    height: 20.sp,
                    width: calcSize(context).longestSide,
                    color: Colors.white,
                  ),
                  Container(
                    height: 20.sp,
                    width: calcSize(context).longestSide,
                    color: Colors.white,
                  ),
                  Container(
                    height: 20.sp,
                    width: calcSize(context).longestSide,
                    color: Colors.white,
                  ),
                ],
              ).withPadding(padding: EdgeInsets.symmetric(horizontal: 05.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
