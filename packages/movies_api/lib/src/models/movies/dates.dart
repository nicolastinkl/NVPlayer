import 'package:equatable/equatable.dart';

class Dates extends Equatable {
  final String? maximum, minimum;

  const Dates({this.maximum, this.minimum});

  Dates.fromJson(Map<String, dynamic> json)
      : maximum = json['maximum'],
        minimum = json['minimum'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maximum'] = maximum;
    data['minimum'] = minimum;
    return data;
  }

  @override
  List<Object?> get props => [maximum, minimum];
}
