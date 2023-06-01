part of 'movie_detail_response.dart';

class ProductionCountries extends Equatable {
  final String? iso31661, name;

  const ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json)
      : iso31661 = json['iso_3166_1'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [iso31661, name];
}
