class NaviAvtor {
  NaviAvtor({
    this.blockId,
    this.title,
    this.clickParam,
    this.layoutType,
    this.resLimit,
    this.categoryId,
    this.resources,
    this.nextStartOffset,
    this.hasMore,
    this.categoryTags,
    this.actorTags,
  });

  String? blockId;
  String? title;
  ClickParam? clickParam;
  String? layoutType;
  int? resLimit;
  String? categoryId;
  List<Resource>? resources;
  int? nextStartOffset;
  bool? hasMore;
  dynamic categoryTags;
  dynamic actorTags;

  factory NaviAvtor.fromJson(Map<String, dynamic> json) => NaviAvtor(
        blockId: json["block_id"],
        title: json["title"],
        clickParam: json["click_param"] == null
            ? null
            : ClickParam.fromJson(json["click_param"]),
        layoutType: json["layout_type"],
        resLimit: json["res_limit"],
        categoryId: json["category_id"],
        resources: json["resources"] == null
            ? []
            : List<Resource>.from(
                json["resources"]!.map((x) => Resource.fromJson(x))),
        nextStartOffset: json["next_start_offset"],
        hasMore: json["has_more"],
        categoryTags: json["category_tags"],
        actorTags: json["actor_tags"],
      );

  Map<String, dynamic> toJson() => {
        "block_id": blockId,
        "title": title,
        "click_param": clickParam?.toJson(),
        "layout_type": layoutType,
        "res_limit": resLimit,
        "category_id": categoryId,
        "resources": resources == null
            ? []
            : List<dynamic>.from(resources!.map((x) => x.toJson())),
        "next_start_offset": nextStartOffset,
        "has_more": hasMore,
        "category_tags": categoryTags,
        "actor_tags": actorTags,
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
  Value? value;

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
    this.initPageIndex,
    this.keyword,
    this.label,
  });

  int? initPageIndex;
  String? keyword;
  List<dynamic>? label;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        initPageIndex: json["initPageIndex"],
        keyword: json["keyword"],
        label: json["label"] == null
            ? []
            : List<dynamic>.from(json["label"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "initPageIndex": initPageIndex,
        "keyword": keyword,
        "label": label == null ? [] : List<dynamic>.from(label!.map((x) => x)),
      };
}

class Resource {
  Resource({
    this.actorAvatarUri,
    this.actorName,
    this.age,
    this.body,
    this.bwh,
    this.followerFlag,
    this.resKey,
    this.resTid,
    this.resTidName,
  });

  String? actorAvatarUri;
  String? actorName;
  String? age;
  String? body;
  String? bwh;
  bool? followerFlag;
  String? resKey;
  int? resTid;
  String? resTidName;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        actorAvatarUri: json["actor_avatar_uri"],
        actorName: json["actor_name"],
        age: json["age"],
        body: json["body"],
        bwh: json["bwh"],
        followerFlag: json["follower_flag"],
        resKey: json["res_key"],
        resTid: json["res_tid"],
        resTidName: json["res_tid_name"],
      );

  Map<String, dynamic> toJson() => {
        "actor_avatar_uri": actorAvatarUri,
        "actor_name": actorName,
        "age": age,
        "body": body,
        "bwh": bwh,
        "follower_flag": followerFlag,
        "res_key": resKey,
        "res_tid": resTid,
        "res_tid_name": resTidName,
      };
}
