class NaviLink {
  NaviLink({
    this.linkId,
    this.title,
    this.iconUri,
    this.clickParam,
  });

  final String? linkId;
  final String? title;
  final String? iconUri;
  final ClickParam? clickParam;

  factory NaviLink.fromJson(Map<String, dynamic> json) => NaviLink(
        linkId: json["link_id"],
        title: json["title"],
        iconUri: json["icon_uri"],
        clickParam: json["click_param"] == null
            ? null
            : ClickParam.fromJson(json["click_param"]),
      );

  Map<String, dynamic> toJson() => {
        "link_id": linkId,
        "title": title,
        "icon_uri": iconUri,
        "click_param": clickParam?.toJson(),
      };
}

class ClickParam {
  ClickParam({
    this.path,
    this.type,
    this.value,
  });

  final String? path;
  final int? type;
  final Value? value;

  factory ClickParam.fromJson(Map<String, dynamic> json) => ClickParam(
        path: json["path"],
        type: json["type"],
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "type": type,
        "value": value?.toJson(),
      };
}

class Value {
  Value({
    this.actorLabel,
    this.anchorLabel,
    this.initPageIndex,
    this.keyword,
    this.label,
    this.modelLabel,
  });

  final List<dynamic>? actorLabel;
  final List<dynamic>? anchorLabel;
  final int? initPageIndex;
  final String? keyword;
  final List<String>? label;
  final List<dynamic>? modelLabel;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        actorLabel: json["actorLabel"] == null
            ? []
            : List<dynamic>.from(json["actorLabel"]!.map((x) => x)),
        anchorLabel: json["anchorLabel"] == null
            ? []
            : List<dynamic>.from(json["anchorLabel"]!.map((x) => x)),
        initPageIndex: json["initPageIndex"],
        keyword: json["keyword"],
        label: json["label"] == null
            ? []
            : List<String>.from(json["label"]!.map((x) => x)),
        modelLabel: json["modelLabel"] == null
            ? []
            : List<dynamic>.from(json["modelLabel"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "actorLabel": actorLabel == null
            ? []
            : List<dynamic>.from(actorLabel!.map((x) => x)),
        "anchorLabel": anchorLabel == null
            ? []
            : List<dynamic>.from(anchorLabel!.map((x) => x)),
        "initPageIndex": initPageIndex,
        "keyword": keyword,
        "label": label == null ? [] : List<dynamic>.from(label!.map((x) => x)),
        "modelLabel": modelLabel == null
            ? []
            : List<dynamic>.from(modelLabel!.map((x) => x)),
      };
}
