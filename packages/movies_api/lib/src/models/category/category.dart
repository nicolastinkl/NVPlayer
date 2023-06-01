// import 'package:equatable/equatable.dart';

class Categroy_Home {
  Categroy_Home({
    this.navbarId,
    this.navbarName,
    this.navbarType,
    this.searchTags,
    this.searchWords,
  });

  String? navbarId;
  String? navbarName;
  String? navbarType;
  List<SearchTag>? searchTags;
  String? searchWords;

  factory Categroy_Home.fromJson(Map<String, dynamic> json) => Categroy_Home(
        navbarId: json["navbar_id"],
        navbarName: json["navbar_name"],
        navbarType: json["navbar_type"],
        searchTags: json["search_tags"] == null
            ? []
            : List<SearchTag>.from(
                json["search_tags"]!.map((x) => SearchTag.fromJson(x))),
        searchWords: json["search_words"],
      );

  Map<String, dynamic> toJson() => {
        "navbar_id": navbarId,
        "navbar_name": navbarName,
        "navbar_type": navbarType,
        "search_tags": searchTags == null
            ? []
            : List<dynamic>.from(searchTags!.map((x) => x.toJson())),
        "search_words": searchWords,
      };
}

class SearchTag {
  SearchTag({
    this.tagId,
    this.tagName,
  });

  String? tagId;
  String? tagName;

  factory SearchTag.fromJson(Map<String, dynamic> json) => SearchTag(
        tagId: json["tag_id"],
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "tag_name": tagName,
      };
}
