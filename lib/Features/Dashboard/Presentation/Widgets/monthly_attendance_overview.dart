import 'package:act/Features/HrManagement/Models/hr_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:sizer/sizer.dart';

class MonthlyAttendanceOverview extends StatelessWidget {
  final MonthlyAttendanceChart monthlyAttendanceChart;

  const MonthlyAttendanceOverview({
    super.key,
    required this.monthlyAttendanceChart,
  });
  List<charts.Series<MonthlyAttendanceOverviewModel, String>>
  _createRandomData() {
    List<MonthlyAttendanceOverviewModel> chartData = [];
    // final dataList = [
    //   MonthlyAttendanceOverviewModel('Jan', 3),
    //   MonthlyAttendanceOverviewModel('Feb', 5),
    //   MonthlyAttendanceOverviewModel('Mar', 7),
    //   MonthlyAttendanceOverviewModel('Apr', 1),
    //   MonthlyAttendanceOverviewModel('May', 5),
    //   MonthlyAttendanceOverviewModel('Jun', 5),
    //   MonthlyAttendanceOverviewModel('Jul', 22),
    //   MonthlyAttendanceOverviewModel('Aug', 25),
    //   MonthlyAttendanceOverviewModel('Sep', 52),
    //   MonthlyAttendanceOverviewModel('Oct', 6),
    //   MonthlyAttendanceOverviewModel('Nov', 19),
    //   MonthlyAttendanceOverviewModel('Dec', 10),
    // ];
    for (var i = 0; i < monthlyAttendanceChart.labels.length; i++) {
      chartData.add(
        MonthlyAttendanceOverviewModel(
          monthlyAttendanceChart.labels[i],
          monthlyAttendanceChart.present[i],
        ),
      );
    }

    return [
      charts.Series<MonthlyAttendanceOverviewModel, String>(
        id: 'Monthly Attendance Overview',
        colorFn: (_, __) => charts.Color.fromHex(code: "#554343"),
        domainFn: (MonthlyAttendanceOverviewModel data, _) => data.label,
        measureFn: (MonthlyAttendanceOverviewModel data, _) => data.value,
        data: chartData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: charts.BarChart(
        _createRandomData(),
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        vertical: false,
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            (num? value) => '${value?.toInt()}',
          ),
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize:
                  10.sp.round(), // Adjust this value to change the font size
              color: charts.MaterialPalette.black,
            ),
          ),
        ),
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize:
                  10.sp.round(), // Adjust this value to change the font size
              color: charts.MaterialPalette.black,
            ),
          ),
        ),
        defaultRenderer: charts.BarRendererConfig(
          // barRendererDecorator: charts.BarLabelDecorator<String>(),
          minBarLengthPx: 02.sp.round(),
          maxBarWidthPx:
              15.sp.round(), // Adjust this value to change the bar width
        ),
        behaviors: const [],
      ),
    );
  }
}

class MonthlyAttendanceOverviewModel {
  final String label;
  final int value;

  MonthlyAttendanceOverviewModel(this.label, this.value);
}
