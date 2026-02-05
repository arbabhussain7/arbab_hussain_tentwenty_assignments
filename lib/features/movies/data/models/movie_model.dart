import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';

class MovieModel {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List<GenreModel>? genres;
  final int? runtime;
  final String? tagline;
  final String? status;
  final int? budget;
  final int? revenue;
  final String? homepage;

  MovieModel({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.genres,
    this.runtime,
    this.tagline,
    this.status,
    this.budget,
    this.revenue,
    this.homepage,
  });

  // From JSON
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'])
          : [],
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      // Movie details fields
      genres: json['genres'] != null
          ? (json['genres'] as List)
                .map((genre) => GenreModel.fromJson(genre))
                .toList()
          : null,
      runtime: json['runtime'],
      tagline: json['tagline'],
      status: json['status'],
      budget: json['budget'],
      revenue: json['revenue'],
      homepage: json['homepage'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'genres': genres?.map((genre) => genre.toJson()).toList(),
      'runtime': runtime,
      'tagline': tagline,
      'status': status,
      'budget': budget,
      'revenue': revenue,
      'homepage': homepage,
    };
  }

  // To Entity
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      genres: genres?.map((genre) => genre.toEntity()).toList(),
      runtime: runtime,
      tagline: tagline,
      status: status,
      budget: budget,
      revenue: revenue,
      homepage: homepage,
    );
  }
}

// Genre Model
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  Genre toEntity() {
    return Genre(id: id, name: name);
  }
}
