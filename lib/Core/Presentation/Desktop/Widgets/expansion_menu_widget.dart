import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExpansionMenuForDeskTop extends StatefulWidget {
  final String title;
  final List<Widget> menuwidget;
  final IconData iconData;
  final bool? initialexpanded;
  final bool? customTileExpanded;
  final double? mobileExpansionIconSize;
  final double? mobileTitleFontSize;
  final double? mobileDropDownIconSize;
  final double? mobileDropDownArrowIconSize;
  const ExpansionMenuForDeskTop(
  // ignore: non_constant_identifier_names
  {
    super.key,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.menuwidget,
    required this.iconData,
    this.initialexpanded,
    this.customTileExpanded,
    this.mobileExpansionIconSize,
    this.mobileTitleFontSize,
    this.mobileDropDownIconSize,
    this.mobileDropDownArrowIconSize,
  });

  @override
  State<ExpansionMenuForDeskTop> createState() => _ExpansionMenuForDeskTop();
}

class _ExpansionMenuForDeskTop extends State<ExpansionMenuForDeskTop> {
  bool customTileExpanded = false;
  @override
  void initState() {
    if (widget.customTileExpanded != null) {
      setState(() {
        customTileExpanded = true;
      });
    } else {
      setState(() {
        customTileExpanded = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calcSize(context).longestSide,
      child: ExpansionTile(
        initiallyExpanded: widget.initialexpanded ?? false,

        // collapsedShape: const RoundedRectangleBorder(
        //   side: BorderSide.none,
        // ),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Row(
          children: [
            Icon(
              widget.iconData,
              color:
                  customTileExpanded
                      ? Colors.black
                      : const Color.fromARGB(255, 177, 177, 177),
              size: widget.mobileExpansionIconSize ?? 12.sp,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(05.sp),
                    child: AppText.medium(
                      widget.title,
                      color:
                          customTileExpanded
                              ? Colors.black
                              : const Color.fromARGB(255, 177, 177, 177),
                      fontSize: widget.mobileTitleFontSize ?? 11.sp,
                      // textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing:
            customTileExpanded
                ? Icon(
                  color: Colors.black,
                  Icons.arrow_drop_down_circle,
                  size: widget.mobileDropDownIconSize ?? 12.sp,
                )
                : RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    color: Colors.grey,
                    Icons.arrow_drop_down,
                    size: widget.mobileDropDownArrowIconSize ?? 13.sp,
                  ),
                ),

        children: widget.menuwidget,
        onExpansionChanged: (bool expanded) {
          setState(() {
            customTileExpanded = expanded;
          });
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
  // Widget buildViewportChrome(
  //     BuildContext context, Widget child, AxisDirection axisDirection) {
  //   return child; // Disable the scroll wheel by not wrapping in any additional chrome
  // }
}
