class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<Genre>? genres;
  final int? runtime;
  final String? tagline;
  final String? status;
  final int? budget;
  final int? revenue;
  final String? homepage;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.genres,
    this.runtime,
    this.tagline,
    this.status,
    this.budget,
    this.revenue,
    this.homepage,
  });

  String? get fullPosterPath {
    if (posterPath == null) return null;
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String? get fullBackdropPath {
    if (backdropPath == null) return null;
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

  String get formattedReleaseDate {
    if (releaseDate == null) return 'Unknown';
    try {
      final date = DateTime.parse(releaseDate!);
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return releaseDate!;
    }
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});
}
