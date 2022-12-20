
import 'package:example/pieces/statistics.dart';

class StatisticsSingleton {
  static final StatisticsSingleton _singleton = StatisticsSingleton._internal();

  factory StatisticsSingleton() {
    return _singleton;
  }

  StatisticsSingleton._internal();

  Statistics? statistics;
}
