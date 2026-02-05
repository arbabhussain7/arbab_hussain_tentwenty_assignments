import 'package:dio_rest_api/features/movies/data/models/movie_model.dart';

class MovieResponseModel {
  final DatesModel? dates;
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      dates: json['dates'] != null ? DatesModel.fromJson(json['dates']) : null,
      page: json['page'] ?? 1,
      results:
          (json['results'] as List?)
              ?.map((movie) => MovieModel.fromJson(movie))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class DatesModel {
  final String? maximum;
  final String? minimum;

  DatesModel({this.maximum, this.minimum});

  factory DatesModel.fromJson(Map<String, dynamic> json) {
    return DatesModel(maximum: json['maximum'], minimum: json['minimum']);
  }

  Map<String, dynamic> toJson() {
    return {'maximum': maximum, 'minimum': minimum};
  }
}
