import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_data.dart';

class MyChart extends StatelessWidget {
  const MyChart({Key? key, required this.titles, required this.data})
      : super(key: key);
  final List<String> titles;
  final List<DataPoints> data;

  @override
  Widget build(BuildContext context) {
    double fontSize = 10;
    if (context.isLandscape) fontSize = 12;
    return SfCartesianChart(
      title: ChartTitle(
          text: 'Sorry\nDid\'t fully implement it due to time shortage'),
      legend: Legend(
          textStyle: TextStyle(fontSize: fontSize),
          isVisible: true,
          overflowMode: LegendItemOverflowMode.scroll,
          position: LegendPosition.bottom),
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          // interval: chartFilters['interval'],
          // intervalType: myData['intervalType'],
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          // labelFormat: '{value}${chartFilters['labelFormat']}',
          labelFormat: '{value}',
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ChartSeries<DataPoints, DateTime>> _getSeries() {
    List<ChartSeries<DataPoints, DateTime>> series = [];
    for (int i = 0; i < titles.length; i++) {
      series.add(
        StackedColumnSeries<DataPoints, DateTime>(
          opacity: 0.85,
          name: titles[i],
          dataSource: data,
          xValueMapper: (DataPoints data, _) => data.x,
          yValueMapper: (DataPoints data, _) =>
              // data.getY(i) / chartFilters['scale'],
              data.getY(i),
          markerSettings:
              // MarkerSettings(isVisible: chartFilters['showMarkers']),
              MarkerSettings(isVisible: false),
          borderRadius: BorderRadius.circular(3.0),
        ),
      );
    }
    return series;
  }
}
