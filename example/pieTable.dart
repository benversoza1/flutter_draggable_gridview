// ignore_for_file: omit_local_variable_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:core';

import 'package:alert/alert.dart';
import 'package:connector_openapi/api/connector_api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api/user_api.dart';
import 'package:core_openapi/api/users_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';

import 'bar chart/persons.dart';
import 'bar chart/related_links.dart';
import 'bar chart/tags/tags.dart';
import 'chart data/boot.dart';
import 'chart data/originPieChart.dart';
import 'chart data/pieChartWidget.dart';
import 'chart data/statistics_singleton.dart';
import 'package:flutter/services.dart';

enum LegendShape { circle, rectangle }

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));
ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: 'http://localhost:1000'));
UsersApi usersApi = UsersApi(ApiClient(basePath: host));
UserApi userApi = UserApi(ApiClient(basePath: host));
List assetsSnapshot = [];
late Future<List> assetsSnapshotFuture = Boot().getAssets();
ApiClient api = ApiClient(basePath: 'http://localhost:1000');
// var isClassification = StatisticsSingleton().statistics?.classifications.containsKey('') ? 0 : 1;

class HomePagePie extends StatelessWidget {
  HomePagePie({Key? key}) : super(key: key);

  get touchedIndex => -1;

  // final Iterable<String>? personEmptyCheck =
  //     StatisticsSingleton().statistics?.persons.where((element) => element.isNotEmpty);
  //
  // final Iterable<String>? tagsEmptyCheck =
  //     StatisticsSingleton().statistics?.tags.where((element) => element.isNotEmpty);
  //
  // final Iterable<String>? relatedLinksEmptyCheck =
  //     StatisticsSingleton().statistics?.relatedLinks.where((element) => element.isNotEmpty);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// add a piece row
          // Container(
          //   color: Colors.transparent,
          //   height: 10,
          //
          //   // child: ,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownRelatedLink(),
                        GlobalTags(),
                        // GlobalTags(),
                        PersonsList(),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [


                  SingleChildScrollView(
                    child: SizedBox(
                      height: 200,
                      width: 600,
                      child: MyPieChart(),
                    ),
                  ),
                  // SizedBox(
                  //   height: 200,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 50.0),
                  //     child: OriginChart(),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),

          /// SPACER ====================
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SizedBox(
              height: 10.0,
              child: Stack(
                textDirection: TextDirection.ltr,
                children: [
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    left: 0.0,
                    bottom: 0.0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      // child: Image.asset(
                      //   'images/piecesLogo.png',
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                tooltip: 'copy',
                elevation: 0,
                mini: true,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.info,
                  color: Colors.black,
                  size: 15,
                ),
                onPressed: () async {
                  ClipboardData data = ClipboardData(text: '''
${StatisticsSingleton().statistics?.user}
${StatisticsSingleton().statistics?.platform}
${StatisticsSingleton().statistics?.version}
''');
                  await Clipboard.setData(data);


                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'User: ${StatisticsSingleton().statistics?.user}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                ),
              ),


            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Time saved while using Pieces: ${StatisticsSingleton().statistics?.timeTaken.round()} seconds',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
            ),
          ),
//           FloatingActionButton(
//             tooltip: 'view your People',
//             elevation: 0,
//             mini: true,
//             backgroundColor: Colors.transparent,
//             child: Icon(
//               Icons.accessibility,
//               color: Colors.black,
//               size: 10,
//             ),
//             onPressed: () async {
//               ClipboardData data = ClipboardData(text: '''
// ${StatisticsSingleton().statistics?.persons}
// ''');
//               await Clipboard.setData(data);
//               SnackBar(
//                 dismissDirection: DismissDirection.down,
//                 backgroundColor: Colors.white,
//                 content: Text(
//                   'Saved',
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 12,
//                   ),
//                 ),
//               );
//
//             },
//           ),

        ],
      ),
    );
  }
}

class GreyTheme {
  static const TextStyle small = TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );
}

class TitleTheme {
  static const TextStyle title = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

class CellTheme {
  static const SizedBox cellBox = SizedBox(
    // height: ,
    width: 120,
  );
}
