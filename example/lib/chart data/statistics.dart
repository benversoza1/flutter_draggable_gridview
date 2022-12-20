import 'package:core_openapi/api.dart';

import '../bar chart/api.dart';

Future<Statistics> getStats() async {
  Assets assets = await PiecesApi.assetsApi.assetsSnapshot();
  ReturnedUserProfile user = await PiecesApi.userApi.userSnapshot();

  /// Activities Information (version, platform)
  Activities activities = await PiecesApi.activitiesApi.activitiesSnapshot();
  Activity first = activities.iterable.first;
  String activity = first.id;
  Activity activitySnapshot =
      await PiecesApi.activityApi.activitiesSpecificActivitySnapshot(activity);
  String version = activitySnapshot.application.version;
  String platform = activitySnapshot.application.platform.value;

  double snippetsSaved = 0;
  double shareableLinks = 0;
  double updatedSnippets = 0;
  double currentMonth = DateTime.now().month.toDouble();
  double totalWordsSaved = 0;
  double timeTaken = 0;

  Map<String, double> tagMap = {};

  /// person map
  Map<String, double> personMap = {};

  /// classifications map (String, double)
  Map<String, double> classifications = {};

  List<String> relatedLinks = [];

  /// origin map (String  :  double)
  Map<String, double> origins = {};
  for (Asset asset in assets.iterable) {
    String? origin = asset.original.reference?.application.name.value;
    String? raw;

    if (origin != null && !origins.containsKey(origin)) {
      origins[origin] = 1;
    } else if (origin != null) {
      origins[origin] = (origins[origin]! + 1);
    }
  }

  for (Asset asset in assets.iterable) {
    String? classification = asset.original.reference?.classification.specific.value;
    String? raw;

    if (asset.original.reference?.classification.generic == ClassificationGenericEnum.CODE) {
      raw = asset.original.reference?.fragment?.string?.raw;
    }



    /// Line count
    if (raw != null) {
      totalWordsSaved = totalWordsSaved + raw.split(' ').length;
    }

    /// Snippets saved in a month
    if (asset.created.value.month == currentMonth) {
      snippetsSaved = snippetsSaved + 1;
    }

    /// Snippets modified in a month
    if (asset.updated.value.month == currentMonth && asset.updated.value != asset.created.value) {
      updatedSnippets = updatedSnippets + 1;
    }
    if (classification != null && !classifications.containsKey(classification)) {
      classifications[classification] = 1;
    } else if (classification != null) {
      classifications[classification] = (classifications[classification]! + 1);
    }

    /// Share links generated
    List<Share>? shares = asset.shares?.iterable;
    for (Share share in shares ?? []) {
      if (share.created.value.month == currentMonth) {
        shareableLinks = shareableLinks + 1;
      }
    }

    /// Top 5 tags
    for (Tag tag in asset.tags?.iterable ?? []) {
      if (tagMap.containsKey(tag.text)) {
        tagMap[tag.text] = tagMap[tag.text]! + 1;
      } else {
        tagMap[tag.text] = 1;
      }
    }

    /// Top 5 people
    for (Person person in asset.persons?.iterable ?? []) {
      if (person.type.basic?.email != null && personMap.containsKey(person.type.basic?.email)) {
        personMap[person.type.basic?.email ?? ""] = personMap[person.type.basic?.email]! + 1;
      } else if (person.type.basic?.email != null) {
        personMap[person.type.basic?.email ?? ""] = 1;
      }
    }

    /// Related Links
    for (Website website in asset.websites?.iterable ?? []) {
      relatedLinks.add(website.url);
    }

    /// Origins
    for (Website website in asset.websites?.iterable ?? []) {
      relatedLinks.add(website.url);
    }
  }

  List<String> tags =
      (Map.fromEntries(tagMap.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value))))
          .keys
          .toList();

  List<String> persons =
      (Map.fromEntries(personMap.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value))))
          .keys
          .toList();

  /// Assuming average wpm is 50, we are calculating the number of seconds for total words
  timeTaken = totalWordsSaved * 1.2;
  if (classifications.isEmpty) {
    classifications[''] = 0;
  }

  Statistics statistics = Statistics(
    activity: activity,
    platform: platform,
    version: version,
    classifications: classifications,
    snippetsSaved: snippetsSaved,
    shareableLinks: shareableLinks,
    updatedSnippets: updatedSnippets,
    timeTaken: timeTaken,
    tags: tags,
    persons: persons,
    relatedLinks: relatedLinks,
    user: user.user?.name ?? user.user?.email ?? '',
    origins: origins,
  );
  return statistics;
}

class Statistics {
  final Map<String, double> classifications;
  final Map<String, double> origins;
  final double snippetsSaved;
  final double shareableLinks;
  final double updatedSnippets;
  final double timeTaken;
  final List<String> tags;
  final List<String> persons;
  final List<String> relatedLinks;
  final String user;
  final String activity;
  final String platform;
  final String version;


  Statistics({
    required this.origins,
    required this.classifications,
    required this.snippetsSaved,
    required this.shareableLinks,
    required this.updatedSnippets,
    required this.timeTaken,
    required this.tags,
    required this.persons,
    required this.relatedLinks,
    required this.user,
    required this.activity,
    required this.platform,
    required this.version,
  });
}
