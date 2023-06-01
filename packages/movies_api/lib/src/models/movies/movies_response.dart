import 'package:equatable/equatable.dart';
import 'package:movies_api/src/models/movies/dates.dart';

import 'movies_data.dart';

class MoviesResponse extends Equatable {
  final Dates? dates;
  final int? page;
  final List<MovieData>? results;
  final int? totalPages;
  final int? totalResults;

  const MoviesResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }

  MoviesResponse.fromJson(Map<String, dynamic> json)
      : dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null,
        page = json['page'],
        results = (json['results'] as List<dynamic>)
            .map((e) => MovieData.fromJson(e))
            .toList(),
        totalPages = json['total_pages'],
        totalResults = json['total_results'];

  @override
  List<Object?> get props => [
        dates,
        page,
        results,
        totalPages,
        totalResults,
      ];
}
