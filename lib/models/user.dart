// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.userName,
    this.userId,
    this.userAccount,
    this.userAgender,
    this.userpassword,
  });

  String? userName;
  String? userId;
  String? userAccount;
  int? userAgender;
  String? userpassword;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json["userName"],
        userId: json["userId"],
        userAccount: json["userAccount"],
        userAgender: json["userAgender"],
        userpassword: json["userpassword"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userId": userId,
        "userAccount": userAccount,
        "userAgender": userAgender,
        "userpassword": userpassword,
      };
}
