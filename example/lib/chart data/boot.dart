import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:core_openapi/api.dart' as core;
// import 'package:connector_openapi/api.dart' as connector;

class Boot {
  Future<bool> connect() async {
    print('Trying to connect..');

    String base = 'localhost:1000';

    Map<String, Map<String, String>> application = {
      "application": {"name": "SUBLIME", "version": "debug", "platform": "MACOS"}
    };

    Uri url = Uri.http(base, '/connect');

    try {
      http.Response response = await http.post(url, body: json.encode(application));
      dynamic decode = json.decode(response.body);
      print('Successful connection to Pieces OS: ');
      // print(decode);
      // '${decode['application']['id']}');
    } catch (e) {
      print('Error connecting to Pieces OS.. $e');
    }

    return true;
  }

  Future<List> getAssets() async {
    String base = 'localhost:1000';
    Uri url = Uri.http(base, '/assets');
    List assets = [];

    try {
      http.Response response = await http.get(url);
      dynamic decode = json.decode(response.body);
      // print('THIS: ${decode["iterable"]}');

      assets = (decode['iterable'] as List);
      // print('==============================================$assets');
    } catch (e) {
      // print('Error connecting to Pieces OS.. $e');
    }

    // print('successfully acquired assets: ${assets}');
    // print('successfully acquired your assets!');

    return assets;
  }

// Future getFormats() async {
//   String base = 'localhost:1000';
//   Uri url = Uri.http(base, '/formats');
//   List formats = [];

//   try {
//     http.Response response = await http.get(url);
//     dynamic decode = json.decode(response.body);
//     print('THIS: ${decode["iterable"]}');
//
//     formats = (decode['iterable'] as List);
//   } catch (err) {
//     print('Your formats error upon call: $err');
//   }
//   print('successfully acquired formats: ${formats}');
//   return formats;
// }
//
// Future create() async {
//   String base = 'localhost:1000';
//   Uri url = Uri.http(base, '/create');
//   List create = [];
//
//   try {
//     http.Response response = await http.get(url);
//     dynamic decode = json.decode(response.body);
//     // print('THIS: ${decode["iterable"]}');
//
//     create = (decode['iterable'] as List);
//   } catch (err) {
//     print('Your formats error upon call: $err');
//   }
//   print('successfully create was successfully called: ${create}');
//   return create;
// }

// Future<asset> assetSnapshot(String asset, {transferables: false}) async {

}
