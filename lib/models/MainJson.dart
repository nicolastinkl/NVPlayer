import 'dart:convert';

class MainJson {
  MainJson({
    this.code,
    this.message,
    this.stat,
  });

  int? code;
  String? message;
  bool? stat;

  factory MainJson.fromJson(Map<String, dynamic> json) => MainJson(
        code: json["code"],
        message: json["message"],
        stat: json["stat"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "stat": stat,
      };
}
