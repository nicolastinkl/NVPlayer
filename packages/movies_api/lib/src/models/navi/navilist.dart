class PageDatumClass {
  PageDatumClass({
    this.containerId,
    this.containerType,
    this.data,
  });

  String? containerId;
  String? containerType;
  List<Datum>? data;

  factory PageDatumClass.fromJson(Map<String, dynamic> json) => PageDatumClass(
        containerId: json["container_id"],
        containerType: json["container_type"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "container_id": containerId,
        "container_type": containerType,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.bannerId,
    this.title,
    this.coverUri,
    this.clickParam,
    this.blockId,
    this.layoutType,
    this.resLimit,
    this.categoryId,
    this.resources,
    this.nextStartOffset,
    this.hasMore,
    this.categoryTags,
    this.actorTags,
    this.linkId,
    this.iconUri,
  });

  String? bannerId;
  String? title;
  String? coverUri;
  ClickParam? clickParam;
  String? blockId;
  String? layoutType;
  int? resLimit;
  String? categoryId;
  List<Resource>? resources;
  int? nextStartOffset;
  bool? hasMore;
  List<String>? categoryTags;
  List<dynamic>? actorTags;
  String? linkId;
  String? iconUri;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bannerId: json["banner_id"],
        title: json["title"],
        coverUri: json["cover_uri"],
        clickParam: json["click_param"] == null
            ? null
            : ClickParam.fromJson(json["click_param"]),
        blockId: json["block_id"],
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
            : List<String>.from(json["category_tags"]!.map((x) => x)),
        actorTags: json["actor_tags"] == null
            ? []
            : List<dynamic>.from(json["actor_tags"]!.map((x) => x)),
        linkId: json["link_id"],
        iconUri: json["icon_uri"],
      );

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "title": title,
        "cover_uri": coverUri,
        "click_param": clickParam?.toJson(),
        "block_id": blockId,
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
        "link_id": linkId,
        "icon_uri": iconUri,
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
  dynamic value;

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

class ValueClass {
  ValueClass({
    this.actorLabel,
    this.anchorLabel,
    this.initPageIndex,
    this.keyword,
    this.label,
    this.modelLabel,
    this.initPageKey,
    this.initSubType,
    this.id,
  });

  List<dynamic>? actorLabel;
  List<dynamic>? anchorLabel;
  int? initPageIndex;
  String? keyword;
  List<dynamic>? label;
  List<dynamic>? modelLabel;
  String? initPageKey;
  String? initSubType;
  String? id;

  factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
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
            : List<dynamic>.from(json["label"]!.map((x) => x)),
        modelLabel: json["modelLabel"] == null
            ? []
            : List<dynamic>.from(json["modelLabel"]!.map((x) => x)),
        initPageKey: json["initPageKey"],
        initSubType: json["initSubType"],
        id: json["id"],
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
        "initPageKey": initPageKey,
        "initSubType": initSubType,
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
    this.authorInfo,
    this.commentTimes,
    this.contents,
    this.dislikeUserFlag,
    this.favoriteFlag,
    this.forwardTimes,
    this.likeUserFlag,
    this.plCategory,
    this.plCover,
    this.plCoverPath,
    this.plResKey,
    this.plTitle,
    this.postId,
    this.resNum,
    this.userid,
    this.actorAvatarUri,
    this.actorName,
    this.age,
    this.body,
    this.bwh,
    this.followerFlag,
    this.resTid,
    this.resTidName,
    this.coverHeight,
    this.coverWidth,
    this.picsetCover,
    this.picsetCoverPath,
    this.picsetItemNum,
    this.picsetTitle,
    this.uploadUserid,
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
  AuthorInfo? authorInfo;
  int? commentTimes;
  List<Content>? contents;
  bool? dislikeUserFlag;
  bool? favoriteFlag;
  int? forwardTimes;
  bool? likeUserFlag;
  int? plCategory;
  String? plCover;
  String? plCoverPath;
  String? plResKey;
  String? plTitle;
  int? postId;
  int? resNum;
  String? userid;
  String? actorAvatarUri;
  String? actorName;
  String? age;
  String? body;
  String? bwh;
  bool? followerFlag;
  int? resTid;
  String? resTidName;
  int? coverHeight;
  int? coverWidth;
  String? picsetCover;
  String? picsetCoverPath;
  int? picsetItemNum;
  String? picsetTitle;
  String? uploadUserid;

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
        authorInfo: json["author_info"] == null
            ? null
            : AuthorInfo.fromJson(json["author_info"]),
        commentTimes: json["comment_times"],
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
        dislikeUserFlag: json["dislike_user_flag"],
        favoriteFlag: json["favorite_flag"],
        forwardTimes: json["forward_times"],
        likeUserFlag: json["like_user_flag"],
        plCategory: json["pl_category"],
        plCover: json["pl_cover"],
        plCoverPath: json["pl_cover_path"],
        plResKey: json["pl_res_key"],
        plTitle: json["pl_title"],
        postId: json["post_id"],
        resNum: json["res_num"],
        userid: json["userid"],
        actorAvatarUri: json["actor_avatar_uri"],
        actorName: json["actor_name"],
        age: json["age"],
        body: json["body"],
        bwh: json["bwh"],
        followerFlag: json["follower_flag"],
        resTid: json["res_tid"],
        resTidName: json["res_tid_name"],
        coverHeight: json["cover_height"],
        coverWidth: json["cover_width"],
        picsetCover: json["picset_cover"],
        picsetCoverPath: json["picset_cover_path"],
        picsetItemNum: json["picset_item_num"],
        picsetTitle: json["picset_title"],
        uploadUserid: json["upload_userid"],
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
        "author_info": authorInfo?.toJson(),
        "comment_times": commentTimes,
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
        "dislike_user_flag": dislikeUserFlag,
        "favorite_flag": favoriteFlag,
        "forward_times": forwardTimes,
        "like_user_flag": likeUserFlag,
        "pl_category": plCategory,
        "pl_cover": plCover,
        "pl_cover_path": plCoverPath,
        "pl_res_key": plResKey,
        "pl_title": plTitle,
        "post_id": postId,
        "res_num": resNum,
        "userid": userid,
        "actor_avatar_uri": actorAvatarUri,
        "actor_name": actorName,
        "age": age,
        "body": body,
        "bwh": bwh,
        "follower_flag": followerFlag,
        "res_tid": resTid,
        "res_tid_name": resTidName,
        "cover_height": coverHeight,
        "cover_width": coverWidth,
        "picset_cover": picsetCover,
        "picset_cover_path": picsetCoverPath,
        "picset_item_num": picsetItemNum,
        "picset_title": picsetTitle,
        "upload_userid": uploadUserid,
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

class AuthorInfo {
  AuthorInfo({
    this.avatarUrl,
    this.nickName,
    this.userid,
  });

  String? avatarUrl;
  String? nickName;
  String? userid;

  factory AuthorInfo.fromJson(Map<String, dynamic> json) => AuthorInfo(
        avatarUrl: json["avatar_url"],
        nickName: json["nick_name"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "nick_name": nickName,
        "userid": userid,
      };
}

class Content {
  Content({
    this.createdTick,
    this.summary,
  });

  int? createdTick;
  Summary? summary;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        createdTick: json["created_tick"],
        summary:
            json["summary"] == null ? null : Summary.fromJson(json["summary"]),
      );

  Map<String, dynamic> toJson() => {
        "created_tick": createdTick,
        "summary": summary?.toJson(),
      };
}

class Summary {
  Summary({
    this.actorResKeys,
    this.duration,
    this.durationStr,
    this.fanNumber,
    this.freeWithinTimeLimit,
    this.playTimes,
    this.resKey,
    this.resTags,
    this.videoCover,
    this.videoCover2,
    this.videoCoverPath,
    this.videoPreview,
    this.videoTitle,
  });

  List<String>? actorResKeys;
  int? duration;
  String? durationStr;
  String? fanNumber;
  bool? freeWithinTimeLimit;
  int? playTimes;
  String? resKey;
  List<ResTag>? resTags;
  String? videoCover;
  String? videoCover2;
  String? videoCoverPath;
  String? videoPreview;
  String? videoTitle;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        actorResKeys: json["actor_res_keys"] == null
            ? []
            : List<String>.from(json["actor_res_keys"]!.map((x) => x)),
        duration: json["duration"],
        durationStr: json["duration_str"],
        fanNumber: json["fan_number"],
        freeWithinTimeLimit: json["free_within_time_limit"],
        playTimes: json["play_times"],
        resKey: json["res_key"],
        resTags: json["res_tags"] == null
            ? []
            : List<ResTag>.from(
                json["res_tags"]!.map((x) => ResTag.fromJson(x))),
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
        "duration": duration,
        "duration_str": durationStr,
        "fan_number": fanNumber,
        "free_within_time_limit": freeWithinTimeLimit,
        "play_times": playTimes,
        "res_key": resKey,
        "res_tags": resTags == null
            ? []
            : List<dynamic>.from(resTags!.map((x) => x.toJson())),
        "video_cover": videoCover,
        "video_cover2": videoCover2,
        "video_cover_path": videoCoverPath,
        "video_preview": videoPreview,
        "video_title": videoTitle,
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
  NickName? nickName;
  String? userid;

  factory UploadUserInfo.fromJson(Map<String, dynamic> json) => UploadUserInfo(
        avatarUri: json["avatar_uri"],
        nickName: nickNameValues.map[json["nick_name"]]!,
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_uri": avatarUri,
        "nick_name": nickNameValues.reverse[nickName],
        "userid": userid,
      };
}

enum NickName { EMPTY }

final nickNameValues = EnumValues({"好色先生官方": NickName.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
