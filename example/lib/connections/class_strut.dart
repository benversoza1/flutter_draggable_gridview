import 'package:core_openapi/api.dart';

import '../bar chart/api.dart';

Future<StatisticsData> getStats() async {
  Assets assets = await PiecesApi.assetsApi.assetsSnapshot();


  ReturnedUserProfile user = await PiecesApi.userApi.userSnapshot();
  String? email = user.user?.email;

  /// Activities Information (version, platform)
  Activities activities = await PiecesApi.activitiesApi.activitiesSnapshot();
  Activity first = activities.iterable.first;
  String activity = first.id;
  Activity activitySnapshot =
  await PiecesApi.activityApi.activitiesSpecificActivitySnapshot(activity);
  String version = activitySnapshot.application.version;
  String platform = activitySnapshot.application.platform.value;



  StatisticsData statisticsData = StatisticsData(

    activity: activity,
    platform: platform,
    version: version,
    user: user.user?.name ?? user.user?.email ?? '',
  );
  return statisticsData;
}

class StatisticsData {
  final String user;
  final String activity;
  final String platform;
  final String version;


  StatisticsData({
    required this.user,
    required this.activity,
    required this.platform,
    required this.version,
  });
}
