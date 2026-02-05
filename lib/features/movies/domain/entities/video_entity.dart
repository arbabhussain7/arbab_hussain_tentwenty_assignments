class VideoEntity {
  final String id;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;

  VideoEntity({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  String get youtubeUrl {
    if (site == 'YouTube') {
      return 'https://www.youtube.com/watch?v=$key';
    }
    return '';
  }

  bool get isTrailer => type.toLowerCase() == 'trailer';
}
