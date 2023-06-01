// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// class RecommendJson
//

class RecommendJson {
  RecommendJson({
    this.awemeList,
    this.hasMore,
    this.statusCode,
  });

  List<AwemeList>? awemeList;
  int? hasMore;
  int? statusCode;

  factory RecommendJson.fromJson(Map<String, dynamic> json) => RecommendJson(
        awemeList: List<AwemeList>.from(
            json["aweme_list"].map((x) => AwemeList.fromJson(x))),
        hasMore: json["has_more"],
        statusCode: json["status_code"],
      );
}

class AwemeList {
  AwemeList({
    this.author,
    this.authorUserId,
    this.createTime,
    this.desc,
    this.music,
    this.region,
    this.shareUrl,
    this.statistics,
    this.video,
  });

  Author? author;
  int? authorUserId;
  int? createTime;
  String? desc;
  Music? music;
  Video? video;

  String? shareUrl;
  Statistics? statistics;

  String? region;

  factory AwemeList.fromJson(Map<String, dynamic> json) => AwemeList(
        author: Author.fromJson(json["author"]),
        music: json["music"] ? null : Music.fromJson(json["music"]),
        statistics: Statistics.fromJson(json["statistics"]),
        video: Video.fromJson(json["video"]),
        region: json["region"],
        shareUrl: json["share_url"],
        authorUserId: json["author_user_id"],
        createTime: json["create_time"],
        desc: json["desc"],
      );
}

class AncestorInfo {
  AncestorInfo({
    this.gid,
    this.productId,
    this.uid,
  });

  double? gid;
  int? productId;
  int? uid;

  factory AncestorInfo.fromJson(Map<String, dynamic> json) => AncestorInfo(
        gid: json["gid"].toDouble(),
        productId: json["product_id"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "gid": gid,
        "product_id": productId,
        "uid": uid,
      };
}

class AnchorInfo {
  AnchorInfo({
    this.displayInfo,
    this.extra,
    this.icon,
    this.id,
    this.logExtra,
    this.mpUrl,
    this.openUrl,
    this.title,
    this.titleTag,
    this.type,
    this.webUrl,
  });

  DisplayInfo? displayInfo;
  String? extra;
  Icon? icon;
  String? id;
  String? logExtra;
  String? mpUrl;
  String? openUrl;
  String? title;
  String? titleTag;
  int? type;
  String? webUrl;

  factory AnchorInfo.fromJson(Map<String, dynamic> json) => AnchorInfo(
        displayInfo: DisplayInfo.fromJson(json["display_info"]),
        extra: json["extra"],
        icon: Icon.fromJson(json["icon"]),
        id: json["id"],
        logExtra: json["log_extra"],
        mpUrl: json["mp_url"],
        openUrl: json["open_url"],
        title: json["title"],
        titleTag: json["title_tag"],
        type: json["type"],
        webUrl: json["web_url"],
      );

  Map<String, dynamic> toJson() => {
        "display_info": displayInfo!.toJson(),
        "extra": extra,
        "icon": icon!.toJson(),
        "id": id,
        "log_extra": logExtra,
        "mp_url": mpUrl,
        "open_url": openUrl,
        "title": title,
        "title_tag": titleTag,
        "type": type,
        "web_url": webUrl,
      };
}

class DisplayInfo {
  DisplayInfo({
    this.afterPlayMs,
    this.afterPlayTimes,
    this.timeSlices,
  });

  int? afterPlayMs;
  int? afterPlayTimes;
  dynamic timeSlices;

  factory DisplayInfo.fromJson(Map<String, dynamic> json) => DisplayInfo(
        afterPlayMs: json["after_play_ms"],
        afterPlayTimes: json["after_play_times"],
        timeSlices: json["time_slices"],
      );

  Map<String, dynamic> toJson() => {
        "after_play_ms": afterPlayMs,
        "after_play_times": afterPlayTimes,
        "time_slices": timeSlices,
      };
}

class Icon {
  Icon({
    this.height,
    this.uri,
    this.urlKey,
    this.urlList,
    this.width,
  });

  int? height;
  String? uri;
  String? urlKey;
  List<String>? urlList;
  int? width;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        height: json["height"],
        uri: json["uri"],
        urlKey: json["url_key"],
        urlList: List<String>.from(json["url_list"].map((x) => x)),
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "uri": uri,
        "url_key": urlKey,
        "url_list": List<dynamic>.from(urlList!.map((x) => x)),
        "width": width,
      };
}

class Author {
  Author({
    this.avatarThumb,
    this.commonInterest,
    this.coverUrl,
    this.customVerify,
    this.enterpriseVerifyReason,
    this.followStatus,
    this.followerStatus,
    this.isAdFake,
    this.nickname,
    this.notSeenItemIdList,
    this.preventDownload,
    this.roomId,
    this.secUid,
    this.shareInfo,
    this.uid,
  });

  Icon? avatarThumb;
  dynamic commonInterest;
  List<Icon>? coverUrl;
  String? customVerify;
  String? enterpriseVerifyReason;
  int? followStatus;
  int? followerStatus;
  bool? isAdFake;
  String? nickname;
  dynamic notSeenItemIdList;
  bool? preventDownload;
  int? roomId;
  String? secUid;
  AuthorShareInfo? shareInfo;
  String? uid;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        avatarThumb: Icon.fromJson(json["avatar_thumb"]),
        commonInterest: json["common_interest"],
        coverUrl:
            List<Icon>.from(json["cover_url"].map((x) => Icon.fromJson(x))),
        customVerify: json["custom_verify"],
        enterpriseVerifyReason: json["enterprise_verify_reason"],
        followStatus: json["follow_status"],
        followerStatus: json["follower_status"],
        isAdFake: json["is_ad_fake"],
        nickname: json["nickname"],
        notSeenItemIdList: json["not_seen_item_id_list"],
        preventDownload: json["prevent_download"],
        roomId: json["room_id"],
        secUid: json["sec_uid"],
        shareInfo: json["share_info"]
            ? null
            : AuthorShareInfo.fromJson(json["share_info"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_thumb": avatarThumb!.toJson(),
        "common_interest": commonInterest,
        "cover_url": List<dynamic>.from(coverUrl!.map((x) => x.toJson())),
        "custom_verify": customVerify,
        "enterprise_verify_reason": enterpriseVerifyReason,
        "follow_status": followStatus,
        "follower_status": followerStatus,
        "is_ad_fake": isAdFake,
        "nickname": nickname,
        "not_seen_item_id_list": notSeenItemIdList,
        "prevent_download": preventDownload,
        "room_id": roomId,
        "sec_uid": secUid,
        "share_info": shareInfo!.toJson(),
        "uid": uid,
      };
}

class AuthorShareInfo {
  AuthorShareInfo({
    this.shareDesc,
    this.shareQrcodeUrl,
    this.shareTitle,
    this.shareTitleMyself,
    this.shareTitleOther,
    this.shareUrl,
    this.shareWeiboDesc,
    this.boolPersist,
  });

  String? shareDesc;
  Icon? shareQrcodeUrl;
  String? shareTitle;
  String? shareTitleMyself;
  String? shareTitleOther;
  String? shareUrl;
  String? shareWeiboDesc;
  int? boolPersist;

  factory AuthorShareInfo.fromJson(Map<String, dynamic> json) =>
      AuthorShareInfo(
        // shareDesc: json["share_desc"],
        shareQrcodeUrl: Icon.fromJson(json["share_qrcode_url"]),
        shareTitle: json["share_title"],
        shareTitleMyself: json["share_title_myself"],
        shareTitleOther: json["share_title_other"],
        shareUrl: json["share_url"],
        shareWeiboDesc: json["share_weibo_desc"],
        boolPersist: json["bool_persist"],
      );

  Map<String, dynamic> toJson() => {
        "share_desc": shareDesc,
        "share_qrcode_url": shareQrcodeUrl!.toJson(),
        "share_title": shareTitle,
        "share_title_myself": shareTitleMyself,
        "share_title_other": shareTitleOther,
        "share_url": shareUrl,
        "share_weibo_desc": shareWeiboDesc,
        "bool_persist": boolPersist,
      };
}

class AwemeControl {
  AwemeControl({
    this.canComment,
    this.canForward,
    this.canShare,
    this.canShowComment,
  });

  bool? canComment;
  bool? canForward;
  bool? canShare;
  bool? canShowComment;

  factory AwemeControl.fromJson(Map<String, dynamic> json) => AwemeControl(
        canComment: json["can_comment"],
        canForward: json["can_forward"],
        canShare: json["can_share"],
        canShowComment: json["can_show_comment"],
      );

  Map<String, dynamic> toJson() => {
        "can_comment": canComment,
        "can_forward": canForward,
        "can_share": canShare,
        "can_show_comment": canShowComment,
      };
}

class DanmakuControl {
  DanmakuControl({
    this.enableDanmaku,
    this.isPostDenied,
    this.postDeniedReason,
    this.postPrivilegeLevel,
  });

  bool? enableDanmaku;
  bool? isPostDenied;
  String? postDeniedReason;
  int? postPrivilegeLevel;

  factory DanmakuControl.fromJson(Map<String, dynamic> json) => DanmakuControl(
        enableDanmaku: json["enable_danmaku"],
        isPostDenied: json["is_post_denied"],
        postDeniedReason: json["post_denied_reason"],
        postPrivilegeLevel: json["post_privilege_level"],
      );

  Map<String, dynamic> toJson() => {
        "enable_danmaku": enableDanmaku,
        "is_post_denied": isPostDenied,
        "post_denied_reason": postDeniedReason,
        "post_privilege_level": postPrivilegeLevel,
      };
}

class Descendants {
  Descendants({
    this.notifyMsg,
    this.platforms,
  });

  String? notifyMsg;
  List<String>? platforms;

  factory Descendants.fromJson(Map<String, dynamic> json) => Descendants(
        notifyMsg: json["notify_msg"],
        platforms: List<String>.from(json["platforms"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "notify_msg": notifyMsg,
        "platforms": List<dynamic>.from(platforms!.map((x) => x)),
      };
}

class DiggLottie {
  DiggLottie({
    this.canBomb,
    this.lottieId,
  });

  int? canBomb;
  String? lottieId;

  factory DiggLottie.fromJson(Map<String, dynamic> json) => DiggLottie(
        canBomb: json["can_bomb"],
        lottieId: json["lottie_id"],
      );

  Map<String, dynamic> toJson() => {
        "can_bomb": canBomb,
        "lottie_id": lottieId,
      };
}

class HotList {
  HotList({
    this.extra,
    this.footer,
    this.groupId,
    this.header,
    this.hotScore,
    this.i18NTitle,
    this.imageUrl,
    this.patternType,
    this.rank,
    this.schema,
    this.sentence,
    this.sentenceId,
    this.title,
    this.type,
    this.viewCount,
  });

  String? extra;
  String? footer;
  String? groupId;
  String? header;
  int? hotScore;
  String? i18NTitle;
  String? imageUrl;
  int? patternType;
  int? rank;
  String? schema;
  String? sentence;
  int? sentenceId;
  String? title;
  int? type;
  int? viewCount;

  factory HotList.fromJson(Map<String, dynamic> json) => HotList(
        extra: json["extra"],
        footer: json["footer"],
        groupId: json["group_id"],
        header: json["header"],
        hotScore: json["hot_score"],
        i18NTitle: json["i18n_title"],
        imageUrl: json["image_url"],
        patternType: json["pattern_type"],
        rank: json["rank"],
        schema: json["schema"],
        sentence: json["sentence"],
        sentenceId: json["sentence_id"],
        title: json["title"],
        type: json["type"],
        viewCount: json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "extra": extra,
        "footer": footer,
        "group_id": groupId,
        "header": header,
        "hot_score": hotScore,
        "i18n_title": i18NTitle,
        "image_url": imageUrl,
        "pattern_type": patternType,
        "rank": rank,
        "schema": schema,
        "sentence": sentence,
        "sentence_id": sentenceId,
        "title": title,
        "type": type,
        "view_count": viewCount,
      };
}

class ImpressionData {
  ImpressionData({
    this.groupIdListA,
    this.groupIdListB,
    this.groupIdListC,
    this.similarIdListA,
    this.similarIdListB,
  });

  List<double>? groupIdListA;
  List<double>? groupIdListB;
  dynamic groupIdListC;
  dynamic similarIdListA;
  List<double>? similarIdListB;

  factory ImpressionData.fromJson(Map<String, dynamic> json) => ImpressionData(
        groupIdListA:
            List<double>.from(json["group_id_list_a"].map((x) => x.toDouble())),
        groupIdListB:
            List<double>.from(json["group_id_list_b"].map((x) => x.toDouble())),
        groupIdListC: json["group_id_list_c"],
        similarIdListA: json["similar_id_list_a"],
        similarIdListB: List<double>.from(
            json["similar_id_list_b"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "group_id_list_a": List<dynamic>.from(groupIdListA!.map((x) => x)),
        "group_id_list_b": List<dynamic>.from(groupIdListB!.map((x) => x)),
        "group_id_list_c": groupIdListC,
        "similar_id_list_a": similarIdListA,
        "similar_id_list_b": List<dynamic>.from(similarIdListB!.map((x) => x)),
      };
}

class Music {
  Music({
    this.album,
    this.artistUserInfos,
    this.auditionDuration,
    this.author,
    this.authorDeleted,
    this.authorPosition,
    this.avatarLarge,
    this.avatarMedium,
    this.avatarThumb,
    this.bindedChallengeId,
    this.collectStat,
    this.coverHd,
    this.coverLarge,
    this.coverMedium,
    this.coverThumb,
    this.duration,
    this.endTime,
    this.externalSongInfo,
    this.extra,
    this.id,
    this.idStr,
    this.isAuthorArtist,
    this.isDelVideo,
    this.isOriginal,
    this.isPgc,
    this.isRestricted,
    this.isVideoSelfSee,
    this.mid,
    this.muteShare,
    this.offlineDesc,
    this.ownerHandle,
    this.ownerId,
    this.ownerNickname,
    this.playUrl,
    this.position,
    this.preventDownload,
    this.preventItemDownloadStatus,
    this.previewEndTime,
    this.previewStartTime,
    this.redirect,
    this.schemaUrl,
    this.secUid,
    this.shootDuration,
    this.sourcePlatform,
    this.startTime,
    this.status,
    this.title,
    this.unshelveCountries,
    this.userCount,
    this.videoDuration,
    this.strongBeatUrl,
    this.isExemptForReply,
  });

  String? album;
  dynamic artistUserInfos;
  int? auditionDuration;
  String? author;
  bool? authorDeleted;
  dynamic authorPosition;
  Icon? avatarLarge;
  Icon? avatarMedium;
  Icon? avatarThumb;
  int? bindedChallengeId;
  int? collectStat;
  Icon? coverHd;
  Icon? coverLarge;
  Icon? coverMedium;
  Icon? coverThumb;
  int? duration;
  int? endTime;
  List<dynamic>? externalSongInfo;
  String? extra;
  double? id;
  String? idStr;
  bool? isAuthorArtist;
  bool? isDelVideo;
  bool? isOriginal;
  bool? isPgc;
  bool? isRestricted;
  bool? isVideoSelfSee;
  String? mid;
  bool? muteShare;
  String? offlineDesc;
  String? ownerHandle;
  String? ownerId;
  String? ownerNickname;
  Icon? playUrl;
  dynamic position;
  bool? preventDownload;
  int? preventItemDownloadStatus;
  int? previewEndTime;
  int? previewStartTime;
  bool? redirect;
  String? schemaUrl;
  String? secUid;
  int? shootDuration;
  int? sourcePlatform;
  int? startTime;
  int? status;
  String? title;
  dynamic unshelveCountries;
  int? userCount;
  int? videoDuration;
  Icon? strongBeatUrl;
  bool? isExemptForReply;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        album: json["album"],
        artistUserInfos: json["artist_user_infos"],
        auditionDuration: json["audition_duration"],
        author: json["author"],
        authorDeleted: json["author_deleted"],
        authorPosition: json["author_position"],
        avatarLarge: Icon.fromJson(json["avatar_large"]),
        avatarMedium: Icon.fromJson(json["avatar_medium"]),
        avatarThumb: Icon.fromJson(json["avatar_thumb"]),
        bindedChallengeId: json["binded_challenge_id"],
        collectStat: json["collect_stat"],
        coverHd: Icon.fromJson(json["cover_hd"]),
        coverLarge: Icon.fromJson(json["cover_large"]),
        coverMedium: Icon.fromJson(json["cover_medium"]),
        coverThumb: Icon.fromJson(json["cover_thumb"]),
        duration: json["duration"],
        endTime: json["end_time"],
        externalSongInfo:
            List<dynamic>.from(json["external_song_info"].map((x) => x)),
        extra: json["extra"],
        id: json["id"].toDouble(),
        idStr: json["id_str"],
        isAuthorArtist: json["is_author_artist"],
        isDelVideo: json["is_del_video"],
        isOriginal: json["is_original"],
        isPgc: json["is_pgc"],
        isRestricted: json["is_restricted"],
        isVideoSelfSee: json["is_video_self_see"],
        mid: json["mid"],
        muteShare: json["mute_share"],
        offlineDesc: json["offline_desc"],
        ownerHandle: json["owner_handle"],
        ownerId: json["owner_id"],
        ownerNickname: json["owner_nickname"],
        playUrl: Icon.fromJson(json["play_url"]),
        position: json["position"],
        preventDownload: json["prevent_download"],
        preventItemDownloadStatus: json["prevent_item_download_status"],
        previewEndTime: json["preview_end_time"],
        previewStartTime: json["preview_start_time"],
        redirect: json["redirect"],
        schemaUrl: json["schema_url"],
        secUid: json["sec_uid"],
        shootDuration: json["shoot_duration"],
        sourcePlatform: json["source_platform"],
        startTime: json["start_time"],
        status: json["status"],
        title: json["title"],
        unshelveCountries: json["unshelve_countries"],
        userCount: json["user_count"],
        videoDuration: json["video_duration"],
        strongBeatUrl: Icon.fromJson(json["strong_beat_url"]),
        isExemptForReply: json["is_exempt_for_reply"],
      );

  Map<String, dynamic> toJson() => {
        "album": album,
        "artist_user_infos": artistUserInfos,
        "audition_duration": auditionDuration,
        "author": author,
        "author_deleted": authorDeleted,
        "author_position": authorPosition,
        "avatar_large": avatarLarge!.toJson(),
        "avatar_medium": avatarMedium!.toJson(),
        "avatar_thumb": avatarThumb!.toJson(),
        "binded_challenge_id": bindedChallengeId,
        "collect_stat": collectStat,
        "cover_hd": coverHd!.toJson(),
        "cover_large": coverLarge!.toJson(),
        "cover_medium": coverMedium!.toJson(),
        "cover_thumb": coverThumb!.toJson(),
        "duration": duration,
        "end_time": endTime,
        "external_song_info":
            List<dynamic>.from(externalSongInfo!.map((x) => x)),
        "extra": extra,
        "id": id,
        "id_str": idStr,
        "is_author_artist": isAuthorArtist,
        "is_del_video": isDelVideo,
        "is_original": isOriginal,
        "is_pgc": isPgc,
        "is_restricted": isRestricted,
        "is_video_self_see": isVideoSelfSee,
        "mid": mid,
        "mute_share": muteShare,
        "offline_desc": offlineDesc,
        "owner_handle": ownerHandle,
        "owner_id": ownerId,
        "owner_nickname": ownerNickname,
        "play_url": playUrl!.toJson(),
        "position": position,
        "prevent_download": preventDownload,
        "prevent_item_download_status": preventItemDownloadStatus,
        "preview_end_time": previewEndTime,
        "preview_start_time": previewStartTime,
        "redirect": redirect,
        "schema_url": schemaUrl,
        "sec_uid": secUid,
        "shoot_duration": shootDuration,
        "source_platform": sourcePlatform,
        "start_time": startTime,
        "status": status,
        "title": title,
        "unshelve_countries": unshelveCountries,
        "user_count": userCount,
        "video_duration": videoDuration,
        "strong_beat_url": strongBeatUrl!.toJson(),
        "is_exempt_for_reply": isExemptForReply,
      };
}

class Statistics {
  Statistics({
    this.collectCount,
    this.commentCount,
    this.diggCount,
    this.downloadCount,
    this.forwardCount,
    this.playCount,
    this.shareCount,
  });

  int? collectCount;
  int? commentCount;
  int? diggCount;
  int? downloadCount;
  int? forwardCount;
  int? playCount;
  int? shareCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        collectCount: json["collect_count"],
        commentCount: json["comment_count"],
        diggCount: json["digg_count"],
        downloadCount: json["download_count"],
        forwardCount: json["forward_count"],
        playCount: json["play_count"],
        shareCount: json["share_count"],
      );

  Map<String, dynamic> toJson() => {
        "collect_count": collectCount,
        "comment_count": commentCount,
        "digg_count": diggCount,
        "download_count": downloadCount,
        "forward_count": forwardCount,
        "play_count": playCount,
        "share_count": shareCount,
      };
}

class Video {
  Video({
    this.cover,
    this.duration,
    this.dynamicCover,
    this.height,
    this.isLongVideo,
    this.meta,
    this.originCover,
    this.playAddr,
    this.playAddr265,
    this.playAddrH264,
    this.ratio,
    this.videoModel,
    this.width,
    this.miscDownloadAddrs,
  });

  Icon? cover;
  int? duration;
  Icon? dynamicCover;
  int? height;
  int? isLongVideo;
  String? meta;
  Icon? originCover;
  PlayAddr? playAddr;
  PlayAddr? playAddr265;
  PlayAddr? playAddrH264;
  String? ratio;
  String? videoModel;
  int? width;
  String? miscDownloadAddrs;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        cover: Icon.fromJson(json["cover"]),
        duration: json["duration"],
        dynamicCover: Icon.fromJson(json["dynamic_cover"]),
        height: json["height"],
        isLongVideo: json["is_long_video"],
        meta: json["meta"],
        originCover: Icon.fromJson(json["origin_cover"]),
        playAddr: PlayAddr.fromJson(json["play_addr"]),
        playAddr265: PlayAddr.fromJson(json["play_addr_265"]),
        playAddrH264: PlayAddr.fromJson(json["play_addr_h264"]),
        ratio: json["ratio"],
        videoModel: json["video_model"],
        width: json["width"],
        miscDownloadAddrs: json["misc_download_addrs"],
      );

  Map<String, dynamic> toJson() => {
        "cover": cover!.toJson(),
        "duration": duration,
        "dynamic_cover": dynamicCover!.toJson(),
        "height": height,
        "is_long_video": isLongVideo,
        "meta": meta,
        "origin_cover": originCover!.toJson(),
        "play_addr": playAddr!.toJson(),
        "play_addr_265": playAddr265!.toJson(),
        "play_addr_h264": playAddrH264!.toJson(),
        "ratio": ratio,
        "video_model": videoModel,
        "width": width,
        "misc_download_addrs": miscDownloadAddrs,
      };
}

class PlayAddr {
  PlayAddr({
    this.dataSize,
    this.fileCs,
    this.fileHash,
    this.height,
    this.urlKey,
    this.urlList,
    this.width,
  });

  int? dataSize;
  String? fileCs;
  String? fileHash;
  int? height;
  String? urlKey;
  List<String>? urlList;
  int? width;

  factory PlayAddr.fromJson(Map<String, dynamic> json) => PlayAddr(
        dataSize: json["data_size"],
        fileCs: json["file_cs"],
        fileHash: json["file_hash"],
        height: json["height"],
        urlKey: json["url_key"],
        urlList: List<String>.from(json["url_list"].map((x) => x)),
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "data_size": dataSize,
        "file_cs": fileCs,
        "file_hash": fileHash,
        "height": height,
        "url_key": urlKey,
        "url_list": List<dynamic>.from(urlList!.map((x) => x)),
        "width": width,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
