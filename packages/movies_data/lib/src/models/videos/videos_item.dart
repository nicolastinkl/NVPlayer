import 'package:equatable/equatable.dart';

class Videos extends Equatable {
  final String id;
  final List<VideoItem> videos;

  Videos({
    required this.id,
    required this.videos,
  });

  @override
  List<Object?> get props => [id, videos];
}

class VideoItem extends Equatable {
  final String id;
  final String size;
  final String key;
  final String name;

  VideoItem({
    required this.name,
    required this.id,
    required this.size,
    required this.key,
  });

  bool compareKey(String? key) {
    return key == this.key;
  }

  @override
  List<Object?> get props => [id, key, size, name];
}
