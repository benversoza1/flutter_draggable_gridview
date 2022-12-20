// ignore_for_file: omit_local_variable_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:core';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../pieces/statistics_singleton.dart';
import 'colors.dart';

// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const MyDataTable(),
//       ),
//     );
//   }
// }

class OriginChart extends StatelessWidget {
  const OriginChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: PieChart(
        ringStrokeWidth: 50,
        centerText: 'ORIGINS',
        chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValueBackground: true,
          decimalPlaces: 0,
          showChartValues: true,
          showChartValuesInPercentage: false,
        ),
        emptyColor: Colors.grey,
        baseChartColor: Colors.black45,
        centerTextStyle: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        key: ValueKey(key),
        dataMap: StatisticsSingleton().statistics!.origins,
        animationDuration: const Duration(milliseconds: 800),
        chartLegendSpacing: 50,
        chartRadius: math.min(MediaQuery.of(context).size.width / 1.5, 180),
        colorList: originColorList,
        chartType: ChartType.ring,
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: true ? BoxShape.circle : BoxShape.rectangle,
          legendTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
