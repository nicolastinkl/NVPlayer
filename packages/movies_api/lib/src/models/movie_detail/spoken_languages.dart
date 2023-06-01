part of 'movie_detail_response.dart';

class SpokenLanguages extends Equatable {
  final String? englishName, iso6391, name;

  const SpokenLanguages({
    this.englishName,
    this.iso6391,
    this.name,
  });

  SpokenLanguages.fromJson(Map<String, dynamic> json)
      : englishName = json['english_name'],
        iso6391 = json['iso_639_1'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [englishName, iso6391, name];
}
