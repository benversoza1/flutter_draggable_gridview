// ignore_for_file: prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:core_openapi/api_client.dart';
import 'package:example/bar%20chart/tags/tags_logic.dart';
import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chart data/statistics_singleton.dart';

class PersonsList extends StatefulWidget {
  const PersonsList({super.key});

  @override
  State<PersonsList> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<PersonsList> {
  String? dropdownValue;

  late Future<List<String>> futureTags;

  @override
  void initState() {
    super.initState();
    AssetTags launch9 = AssetTags(
      api: ApiClient(basePath: 'http://localhost:1000'),
    );

    futureTags = launch9.run();
  }

  List list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureTags,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (!snapshot.hasData) {
            return Text('Failure...');
          }

          // print('gathered related links data!');

          dropdownValue ??= snapshot.data!.first;

          List<String>? personsList = StatisticsSingleton().statistics?.persons;

          List<DropdownMenuItem<String>> items = snapshot.data!
              .map(
                (String url) => DropdownMenuItem<String>(
                  value: url,
                  child: SizedBox(
                    child: Text('Emails'),
                  ),
                ),
              )
              .toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
              child: Container(
                color: Colors.black87,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.email_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    Container(
                      // color: Colors.grey,
                      width: 150,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          onTap: () async {},

                          enableFeedback: true,
                          value: dropdownValue,
                          style: ParticleFont.micro(
                            context,
                            customization: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          isExpanded: true,
                          menuMaxHeight: 250,

                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Badge(
                              badgeColor: Colors.white,
                              position: BadgePosition(isCenter: true),
                              badgeContent: Text(
                                '${StatisticsSingleton().statistics?.persons.length}',
                                style: ParticleFont.micro(
                                  context,
                                  customization: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          elevation: 16,

                          underline: Container(
                            height: 0,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: items,
                          // items: Languages.map<DropdownMenuItem<String>>((String value) {
                          //   return DropdownMenuItem<String>(
                          //     value: value,
                          //     child: Text(value),
                          //   );
                          // }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
