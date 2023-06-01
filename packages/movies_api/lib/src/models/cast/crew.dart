class Crew {
  Crew({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.department,
    this.job,
  });

  Crew.fromJson(dynamic json)
      : adult = json['adult'],
        gender = json['gender'],
        id = json['id'],
        knownForDepartment = json['known_for_department'],
        originalName = json['original_name'],
        popularity = json['popularity'],
        profilePath = json['profile_path'],
        creditId = json['credit_id'],
        department = json['department'],
        job = json['job'];

  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? creditId;
  final String? department;
  final String? job;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['gender'] = gender;
    map['id'] = id;
    map['known_for_department'] = knownForDepartment;
    map['original_name'] = originalName;
    map['popularity'] = popularity;
    map['profile_path'] = profilePath;
    map['credit_id'] = creditId;
    map['department'] = department;
    map['job'] = job;
    return map;
  }
}
