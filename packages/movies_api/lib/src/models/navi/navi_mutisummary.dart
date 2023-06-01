class NaviMutiSummary {
  NaviMutiSummary({
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
  List<dynamic>? categoryTags;
  List<dynamic>? actorTags;

  factory NaviMutiSummary.fromJson(Map<String, dynamic> json) =>
      NaviMutiSummary(
        blockId: json["block_id"],
        title: json["title"],
        // clickParam: json["click_param"] == null
        //     ? null
        //     : ClickParam.fromJson(json["click_param"]),
        layoutType: json["layout_type"],
        resLimit: json["res_limit"],
        categoryId: json["category_id"],
        resources: json["resources"] == null
            ? []
            : List<Resource>.from(
                json["resources"]!.map((x) => Resource.fromJson(x))),
        nextStartOffset: json["next_start_offset"],
        hasMore: json["has_more"],
        categoryTags: json["category_tags"] == null
            ? []
            : List<dynamic>.from(json["category_tags"]!.map((x) => x)),
        actorTags: json["actor_tags"] == null
            ? []
            : List<dynamic>.from(json["actor_tags"]!.map((x) => x)),
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
        "category_tags": categoryTags == null
            ? []
            : List<dynamic>.from(categoryTags!.map((x) => x)),
        "actor_tags": actorTags == null
            ? []
            : List<dynamic>.from(actorTags!.map((x) => x)),
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
    this.id,
  });

  String? id;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Resource {
  Resource({
    this.actorResKeys,
    this.actors,
    this.createdTick,
    this.duration,
    this.durationStr,
    this.fanNumber,
    this.favoriteUsers,
    this.freeWithinTimeLimit,
    this.likeUsers,
    this.playTimes,
    this.resKey,
    this.resTags,
    this.uploadUserInfo,
    this.videoCover,
    this.videoCover2,
    this.videoCoverPath,
    this.videoPreview,
    this.videoTitle,
  });

  List<String>? actorResKeys;
  List<Actor>? actors;
  int? createdTick;
  int? duration;
  String? durationStr;
  String? fanNumber;
  int? favoriteUsers;
  bool? freeWithinTimeLimit;
  int? likeUsers;
  int? playTimes;
  String? resKey;
  List<ResTag>? resTags;
  UploadUserInfo? uploadUserInfo;
  String? videoCover;
  String? videoCover2;
  String? videoCoverPath;
  String? videoPreview;
  String? videoTitle;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        actorResKeys: json["actor_res_keys"] == null
            ? []
            : List<String>.from(json["actor_res_keys"]!.map((x) => x)),
        actors: json["actors"] == null
            ? []
            : List<Actor>.from(json["actors"]!.map((x) => Actor.fromJson(x))),
        createdTick: json["created_tick"],
        duration: json["duration"],
        durationStr: json["duration_str"],
        fanNumber: json["fan_number"],
        favoriteUsers: json["favorite_users"],
        freeWithinTimeLimit: json["free_within_time_limit"],
        likeUsers: json["like_users"],
        playTimes: json["play_times"],
        resKey: json["res_key"],
        resTags: json["res_tags"] == null
            ? []
            : List<ResTag>.from(
                json["res_tags"]!.map((x) => ResTag.fromJson(x))),
        uploadUserInfo: json["upload_user_info"] == null
            ? null
            : UploadUserInfo.fromJson(json["upload_user_info"]),
        videoCover: json["video_cover"],
        videoCover2: json["video_cover2"],
        videoCoverPath: json["video_cover_path"],
        videoPreview: json["video_preview"],
        videoTitle: json["video_title"],
      );

  Map<String, dynamic> toJson() => {
        "actor_res_keys": actorResKeys == null
            ? []
            : List<dynamic>.from(actorResKeys!.map((x) => x)),
        "actors": actors == null
            ? []
            : List<dynamic>.from(actors!.map((x) => x.toJson())),
        "created_tick": createdTick,
        "duration": duration,
        "duration_str": durationStr,
        "fan_number": fanNumber,
        "favorite_users": favoriteUsers,
        "free_within_time_limit": freeWithinTimeLimit,
        "like_users": likeUsers,
        "play_times": playTimes,
        "res_key": resKey,
        "res_tags": resTags == null
            ? []
            : List<dynamic>.from(resTags!.map((x) => x.toJson())),
        "upload_user_info": uploadUserInfo?.toJson(),
        "video_cover": videoCover,
        "video_cover2": videoCover2,
        "video_cover_path": videoCoverPath,
        "video_preview": videoPreview,
        "video_title": videoTitle,
      };
}

class Actor {
  Actor({
    this.actorAvatarUri,
    this.actorName,
    this.actorResKey,
    this.followers,
    this.resTid,
  });

  String? actorAvatarUri;
  String? actorName;
  String? actorResKey;
  int? followers;
  int? resTid;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        actorAvatarUri: json["actor_avatar_uri"],
        actorName: json["actor_name"],
        actorResKey: json["actor_res_key"],
        followers: json["followers"],
        resTid: json["res_tid"],
      );

  Map<String, dynamic> toJson() => {
        "actor_avatar_uri": actorAvatarUri,
        "actor_name": actorName,
        "actor_res_key": actorResKey,
        "followers": followers,
        "res_tid": resTid,
      };
}

class ResTag {
  ResTag({
    this.tagId,
    this.tagName,
  });

  String? tagId;
  String? tagName;

  factory ResTag.fromJson(Map<String, dynamic> json) => ResTag(
        tagId: json["tag_id"],
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "tag_name": tagName,
      };
}

class UploadUserInfo {
  UploadUserInfo({
    this.avatarUri,
    this.nickName,
    this.userid,
  });

  String? avatarUri;
  String? nickName;
  String? userid;

  factory UploadUserInfo.fromJson(Map<String, dynamic> json) => UploadUserInfo(
        avatarUri: json["avatar_uri"],
        nickName: json["nick_name"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_uri": avatarUri,
        "nick_name": nickName,
        "userid": userid,
      };
}
