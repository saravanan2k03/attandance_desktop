import 'package:act/Features/EmployeeManagement/Models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class piechartWidget extends StatefulWidget {
  final double? mobilePieChartCenterSpaceRadius;
  final double? mobileTouchedPiechartfontSize;
  final double? mobileTouchedPiechartradius;
  final double? mobilePiechartradius;
  final double? mobilePiechartfontSize;
  final String? mobileview;
  final List<ChartData>? colorsectionData;
  const piechartWidget({
    super.key,
    this.mobilePieChartCenterSpaceRadius,
    this.mobileTouchedPiechartfontSize,
    this.mobileTouchedPiechartradius,
    this.mobilePiechartradius,
    this.mobilePiechartfontSize,
    this.mobileview,
    this.colorsectionData,
  });

  @override
  State<piechartWidget> createState() => _piechartWidgetState();
}

class _piechartWidgetState extends State<piechartWidget> {
  int touchedIndex = -1;
  List<PieChartSectionData> feedModelDataToPiechart(
    int touchedIndex,
    List<ChartData>? modelData,
  ) {
    return modelData!
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchedIndex;
          final double fontSize =
              isTouched
                  ? widget.mobileTouchedPiechartfontSize ?? 11.sp
                  : widget.mobilePiechartfontSize ?? 09.sp;
          final double radius =
              isTouched
                  ? widget.mobileTouchedPiechartradius ?? 23.sp
                  : widget.mobilePiechartradius ?? 20.sp;
          var colormodel = modelData[index];
          colormodel = colormodel.copyWith(
            code: data.code,
            title: data.title,
            value: data.value,
            color: data.color,
          );
          final value = PieChartSectionData(
            color: colormodel.color,
            value: colormodel.value,
            title: colormodel.code,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
          return MapEntry(index, value);
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PieChart(
        PieChartData(
          pieTouchData:
              widget.mobileview == null
                  ? null
                  : PieTouchData(
                    mouseCursorResolver: (event, response) {
                      setState(() {
                        if (response!.touchedSection is FlLongPressEnd ||
                            response.touchedSection is FlPanEndEvent) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        }
                      });

                      // Return a default cursor based on the condition
                      if (response!.touchedSection != null) {
                        return SystemMouseCursors.click;
                      } else {
                        return SystemMouseCursors.basic;
                      }
                    },
                    touchCallback: (event, respone) {
                      setState(() {
                        if (respone!.touchedSection is FlLongPressEnd ||
                            respone.touchedSection is FlPanEndEvent) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex =
                              respone.touchedSection!.touchedSectionIndex;
                        }
                      });
                    },
                  ),
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: widget.mobilePieChartCenterSpaceRadius ?? 20.sp,
          sections: feedModelDataToPiechart(
            touchedIndex,
            widget.colorsectionData,
          ),
        ),
      ),
    );
  }
}
