class Cast {
  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  Cast.fromJson(dynamic json)
      : adult = json['adult'],
        gender = json['gender'],
        id = json['id'],
        knownForDepartment = json['known_for_department'],
        originalName = json['original_name'],
        popularity = json['popularity'],
        profilePath = json['profile_path'],
        castId = json['cast_id'],
        character = json['character'],
        creditId = json['credit_id'],
        order = json['order'];

  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['gender'] = gender;
    map['id'] = id;
    map['known_for_department'] = knownForDepartment;
    map['original_name'] = originalName;
    map['popularity'] = popularity;
    map['profile_path'] = profilePath;
    map['cast_id'] = castId;
    map['character'] = character;
    map['credit_id'] = creditId;
    map['order'] = order;
    return map;
  }
}
