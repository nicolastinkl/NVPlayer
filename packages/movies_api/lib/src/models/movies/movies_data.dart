import 'package:equatable/equatable.dart';

class MovieData extends Equatable {
  final String? id;
  final String? backdropPath;
  final String? originalLanguage;
  final String? overview;
  final String? posterPath;
  final String? title;
  final String? voteAverage;

  const MovieData({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.overview,
    this.posterPath,
    this.title,
    this.voteAverage,
  });

  MovieData.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'],
        id = json['id'].toString(),
        originalLanguage = json['original_language'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        title = json['title'],
        voteAverage = json['vote_average'].toString();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['title'] = title;
    data['vote_average'] = voteAverage;
    return data;
  }

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        originalLanguage,
        overview,
        posterPath,
        title,
        voteAverage
      ];
}
