class NaviNewestItem {
  NaviNewestItem({
    this.resKey,
    this.resTags,
    this.actorResKeys,
    this.playTimes,
    this.likeUsers,
    this.dislikeUsers,
    this.commentTimes,
    this.videoTitle,
    this.videoCover,
    this.videoCover2,
    this.videoPreview,
    this.durationStr,
    this.duration,
    this.freeWithinTimeLimit,
    this.createdTick,
    this.directorNames,
    this.fanNumber,
    this.profile,
    this.uploadUserInfo,
    this.videoClarities,
    this.likeUserFlag,
    this.dislikeUserFlag,
    this.favoriteFlag,
  });

  String? resKey;
  List<ResTag>? resTags;
  List<dynamic>? actorResKeys;
  int? playTimes;
  int? likeUsers;
  int? dislikeUsers;
  int? commentTimes;
  String? videoTitle;
  String? videoCover;
  String? videoCover2;
  String? videoPreview;
  String? durationStr;
  int? duration;
  bool? freeWithinTimeLimit;
  int? createdTick;
  List<dynamic>? directorNames;
  String? fanNumber;
  String? profile;
  UploadUserInfo? uploadUserInfo;
  List<dynamic>? videoClarities;
  bool? likeUserFlag;
  bool? dislikeUserFlag;
  bool? favoriteFlag;

  factory NaviNewestItem.fromJson(Map<String, dynamic> json) => NaviNewestItem(
        resKey: json["res_key"],
        resTags: json["res_tags"] == null
            ? []
            : List<ResTag>.from(
                json["res_tags"]!.map((x) => ResTag.fromJson(x))),
        actorResKeys: json["actor_res_keys"] == null
            ? []
            : List<dynamic>.from(json["actor_res_keys"]!.map((x) => x)),
        playTimes: json["play_times"],
        likeUsers: json["like_users"],
        dislikeUsers: json["dislike_users"],
        commentTimes: json["comment_times"],
        videoTitle: json["video_title"],
        videoCover: json["video_cover"],
        videoCover2: json["video_cover2"],
        videoPreview: json["video_preview"],
        durationStr: json["duration_str"],
        duration: json["duration"],
        freeWithinTimeLimit: json["free_within_time_limit"],
        createdTick: json["created_tick"],
        directorNames: json["director_names"] == null
            ? []
            : List<dynamic>.from(json["director_names"]!.map((x) => x)),
        fanNumber: json["fan_number"],
        profile: json["profile"],
        uploadUserInfo: json["upload_user_info"] == null
            ? null
            : UploadUserInfo.fromJson(json["upload_user_info"]),
        videoClarities: json["video_clarities"] == null
            ? []
            : List<dynamic>.from(json["video_clarities"]!.map((x) => x)),
        likeUserFlag: json["like_user_flag"],
        dislikeUserFlag: json["dislike_user_flag"],
        favoriteFlag: json["favorite_flag"],
      );

  Map<String, dynamic> toJson() => {
        "res_key": resKey,
        "res_tags": resTags == null
            ? []
            : List<dynamic>.from(resTags!.map((x) => x.toJson())),
        "actor_res_keys": actorResKeys == null
            ? []
            : List<dynamic>.from(actorResKeys!.map((x) => x)),
        "play_times": playTimes,
        "like_users": likeUsers,
        "dislike_users": dislikeUsers,
        "comment_times": commentTimes,
        "video_title": videoTitle,
        "video_cover": videoCover,
        "video_cover2": videoCover2,
        "video_preview": videoPreview,
        "duration_str": durationStr,
        "duration": duration,
        "free_within_time_limit": freeWithinTimeLimit,
        "created_tick": createdTick,
        "director_names": directorNames == null
            ? []
            : List<dynamic>.from(directorNames!.map((x) => x)),
        "fan_number": fanNumber,
        "profile": profile,
        "upload_user_info": uploadUserInfo?.toJson(),
        "video_clarities": videoClarities == null
            ? []
            : List<dynamic>.from(videoClarities!.map((x) => x)),
        "like_user_flag": likeUserFlag,
        "dislike_user_flag": dislikeUserFlag,
        "favorite_flag": favoriteFlag,
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
    this.userid,
    this.nickName,
    this.avatarUri,
  });

  String? userid;
  String? nickName;
  String? avatarUri;

  factory UploadUserInfo.fromJson(Map<String, dynamic> json) => UploadUserInfo(
        userid: json["userid"],
        nickName: json["nick_name"],
        avatarUri: json["avatar_uri"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "nick_name": nickName,
        "avatar_uri": avatarUri,
      };
}
