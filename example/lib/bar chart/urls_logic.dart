// ignore_for_file: non_constant_identifier_names

import 'dart:core';

import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api_client.dart';

/// Recipe #3: I want to get a list of all of my code assets

List<String> Url_List = [];

// void main() async {
//   AssetWebsite launch9 = AssetWebsite(api: ApiClient(basePath: 'http://localhost:1000'));
//   launch9.run();
// }

class AssetWebsite {
  late final AssetsApi assetsApi;
  late final AssetApi assetApi;
  late final ApiClient api;

//Step (1) initialize Api
  AssetWebsite({required ApiClient api}) {
    assetsApi = AssetsApi(api);
    assetApi = AssetApi(api);
  }
  Future<List<String>> run() async {
    /// (2) snapshot

    Assets assetsSnapshot = await assetsApi.assetsSnapshot();

    /// (3) creat local var

    /// (4) && (5) iterate over our snapshot.
    /// option 1 normal for loop
    List<String> websiteUrls = [];
    websiteUrls.add('Related Links');
    for (Asset asset in assetsSnapshot.iterable) {
      // if (asset.original.reference?.websites.toString() == FlattenedWebsites) {
      //   /// add to our list!
      //   websites.iterable.add(asset);
      // }
      websiteUrls = [
        ...websiteUrls,
        ...(asset.websites?.iterable.map((e) => e.url).toList() ?? [])
      ];
    }

    /// this last step here will just filter out an empty strings.
    websiteUrls = websiteUrls.map((e) => e).toList();
    final uniqueList = websiteUrls.toSet().toList();
    // uniqueList.add('related links');
    print('link count: ${uniqueList.length}');
    return uniqueList;

    /// (6) print our new codeAssets
    // print('here are our url assets $websiteUrls');
  }
}

/// option 2 use a reduce fn.
/// TODO add a reduce here.
