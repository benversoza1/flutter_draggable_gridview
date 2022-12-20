import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../pieces/statistics_singleton.dart';
import 'indicator.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Indicator(
                  color: Color(0xfffa9d2c),
                  text: 'JetBrains',
                  isSquare: false,
                  size: touchedIndex == 0 ? 18 : 16,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: Colors.lightBlueAccent,
                  text: 'VS Code',
                  isSquare: false,
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: Colors.grey,
                  text: 'PFD',
                  isSquare: false,
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: Colors.blueGrey,
                  text: 'Chrome Ext',
                  isSquare: false,
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: Colors.green,
                  text: 'CLI',
                  isSquare: false,
                  size: touchedIndex == 4 ? 18 : 16,
                  textColor: touchedIndex == 4 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: Colors.black,
                  text: 'OS_Sever',
                  isSquare: false,
                  size: touchedIndex == 5 ? 18 : 16,
                  textColor: touchedIndex == 5 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: Colors.redAccent,
                  text: 'FireFox',
                  isSquare: false,
                  size: touchedIndex == 6 ? 18 : 16,
                  textColor: touchedIndex == 6 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  swapAnimationDuration: const Duration(milliseconds: 800),
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 50,
                    sections: showingSections(),
                    startDegreeOffset: 180,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      8,
      growable: true,
      (i) {
        final isTouched = i == touchedIndex;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.orange,
              title: 'Jet Brains: ${StatisticsSingleton().statistics?.version ?? 0}',
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          case 1:
            return PieChartSectionData(
              showTitle: true,
              color: Colors.lightBlueAccent,
              title: 'VS Code: ${StatisticsSingleton().statistics?.version ?? 0}',
              value: StatisticsSingleton().statistics?.shareableLinks ?? 0,
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          case 2:
            return PieChartSectionData(
              color: Colors.grey,
              title: 'PFD: ${StatisticsSingleton().statistics?.shareableLinks ?? 0}',
              value: StatisticsSingleton().statistics?.snippetsSaved ?? 0,
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          case 3:
            return PieChartSectionData(
              color: Colors.blueGrey,
              title: 'Chrome Ext: ${StatisticsSingleton().statistics?.activity ?? 0}',
              value: StatisticsSingleton().statistics?.updatedSnippets ?? 0,
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          case 4:
            return PieChartSectionData(
              color: Colors.green,
              title: 'CLI: ${StatisticsSingleton().statistics?.version ?? 0}',
              value: StatisticsSingleton().statistics?.snippetsSaved ?? 0,
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          case 5:
            return PieChartSectionData(
              // showTitle: true,
              title: 'OS Server: ${StatisticsSingleton().statistics?.snippetsSaved ?? 0}',
              color: Colors.black38,
              value: StatisticsSingleton().statistics?.updatedSnippets ?? 0,
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          case 6:
            return PieChartSectionData(
              // showTitle: true,
              title: 'FireFox: ${StatisticsSingleton().statistics?.version ?? 0}',
              color: Colors.red,
              value: StatisticsSingleton().statistics?.updatedSnippets ?? 0,
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titlePositionPercentageOffset: 1.5,
            );
          default:
            throw Error();
        }
      },
    );
  }
}
