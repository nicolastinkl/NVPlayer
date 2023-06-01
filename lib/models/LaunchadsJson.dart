import 'dart:convert';

class LaunchadsJson {
  LaunchadsJson({
    this.adimageurl,
    this.adimageclickurl,
    this.adtimes,
    this.show,
  });

  String? adimageurl;
  String? adimageclickurl;
  int? adtimes;
  int? show;

  factory LaunchadsJson.fromJson(Map<String, dynamic> json) => LaunchadsJson(
        adimageurl: json["adimageurl"],
        adimageclickurl: json["adimageclickurl"],
        adtimes: json["adtimes"],
        show: json["show"],
      );

  Map<String, dynamic> toJson() => {
        "adimageurl": adimageurl,
        "adimageclickurl": adimageclickurl,
        "adtimes": adtimes,
        "show": show,
      };
}
