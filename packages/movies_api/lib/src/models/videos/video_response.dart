import 'package:equatable/equatable.dart';

import 'video_data.dart';

class VideosResponse extends Equatable {
  late final int? id;
  late final List<Results>? results;

  VideosResponse({
    required this.id,
    required this.results,
  });

  VideosResponse.fromJson(dynamic json) {
    id = json['id'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (results != null) {
      map['results'] = results!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  List<Object?> get props => [id, results];
}
