class Navi_Banner {
  Navi_Banner({
    this.bannerId,
    this.title,
    this.coverUri,
    this.clickParam,
  });

  String? bannerId;
  String? title;
  String? coverUri;
  ClickParam? clickParam;

  factory Navi_Banner.fromJson(Map<String, dynamic> json) => Navi_Banner(
        bannerId: json["banner_id"],
        title: json["title"],
        coverUri: json["cover_uri"],
        clickParam: json["click_param"] == null
            ? null
            : ClickParam.fromJson(json["click_param"]),
      );

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "title": title,
        "cover_uri": coverUri,
        "click_param": clickParam?.toJson(),
      };
}

class ClickParam {
  ClickParam({
    this.path,
    this.type,
    this.value,
  });

  String? path;
  int? type;
  int? value;

  factory ClickParam.fromJson(Map<String, dynamic> json) => ClickParam(
        path: json["path"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "type": type,
        "value": value,
      };
}
