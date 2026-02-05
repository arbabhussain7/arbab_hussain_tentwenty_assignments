import 'package:dio_rest_api/core/api/api_client.dart';
import 'package:dio_rest_api/core/api/api_endpoints.dart';
import 'package:dio_rest_api/features/movies/data/models/movie_model.dart';
import 'package:dio_rest_api/features/movies/data/models/movie_response_model.dart';
import 'package:dio_rest_api/features/movies/data/models/video_model.dart';
import 'package:dio_rest_api/features/movies/data/models/video_response_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getUpcomingMovies({int page = 1});
  Future<MovieModel> getMovieDetails(int movieId);
  Future<List<VideoModel>> getMovieVideos(int movieId);
  Future<List<MovieModel>> searchMovies(String query, {int page = 1});
  Future<List<MovieModel>> getPopularMovies({int page = 1});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;

  MovieRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> getUpcomingMovies({int page = 1}) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.upcomingMovies,
        queryParameters: {
          'api_key': ApiEndpoints.tmdbApiKey,
          'language': 'en-US',
          'page': page,
        },
      );

      final movieResponse = MovieResponseModel.fromJson(response.data);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to fetch upcoming movies: $e');
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.movieDetails(movieId),
        queryParameters: {
          'api_key': ApiEndpoints.tmdbApiKey,
          'language': 'en-US',
        },
      );

      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }

  @override
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.movieVideos(movieId),
      );

      final videoResponse = VideoResponseModel.fromJson(response.data);
      return videoResponse.results;
    } catch (e) {
      throw Exception('Failed to fetch movie videos: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.searchMovies(query, page: page),
      );

      final movieResponse = MovieResponseModel.fromJson(response.data);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.popularMovies,
        queryParameters: {
          'api_key': ApiEndpoints.tmdbApiKey,
          'language': 'en-US',
          'page': page,
        },
      );

      final movieResponse = MovieResponseModel.fromJson(response.data);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Failed to fetch popular movies: $e');
    }
  }
}
