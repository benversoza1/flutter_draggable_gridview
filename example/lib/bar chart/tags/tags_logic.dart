// ignore_for_file: non_constant_identifier_names

import 'dart:core';

import 'package:core_openapi/api.dart';
import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api_client.dart';

/// Recipe #3: I want to get a list of all of my code assets

List<String> Url_List = [];

void main() async {
  AssetTags launch = AssetTags(api: ApiClient(basePath: 'http://localhost:1000'));
  launch.run();
}

class AssetTags {
  late final Tags tagsApi;
  late final TagApi tagApi;
  late final ApiClient api;
  late final AssetsApi assetsApi;
  late final AssetApi assetApi;

//Step (1) initialize Api
  AssetTags({required ApiClient api}) {
    // tagsApi = Tags(api);
    assetsApi = AssetsApi(api);
    assetApi = AssetApi(api);

    tagApi = TagApi(api);
  }
  Future<List<String>> run() async {
    /// (2) snapshot
    Assets assetsSnapshot = await assetsApi.assetsSnapshot();

    /// (3) creat local var

    /// (4) && (5) iterate over our snapshot.
    /// option 1 normal for loop
    List<String> tagsList = [];
    tagsList.add('Tags');
    for (Asset asset in assetsSnapshot.iterable) {
      tagsList = [...tagsList, ...(asset.tags?.iterable.map((e) => e.text).toList() ?? [])];

      // if (asset.original.reference?.websites.toString() == FlattenedWebsites) {
      //   /// add to our list!
      //   websites.iterable.add(asset);
      // }
      tagsList = [...tagsList, ...(asset.websites?.iterable.map((e) => e.url).toList() ?? [])];
    }

    /// this last step here will just filter out an empty strings.
    tagsList = tagsList.map((e) => e).toList();
    final uniqueList = tagsList.toSet().toList();
    print('tag count: ${uniqueList.length}');
    return uniqueList;

    /// (6) print our new codeAssets
    // print('here are our url assets $websiteUrls');
  }
}

/// option 2 use a reduce fn.
/// TODO add a reduce here.
