import 'package:dartz/dartz.dart';
import 'package:dio_rest_api/core/errors/failures.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/features/movies/domain/entities/video_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies({int page = 1});

  Future<Either<Failure, MovieEntity>> getMovieDetails(int movieId);

  Future<Either<Failure, List<VideoEntity>>> getMovieVideos(int movieId);

  Future<Either<Failure, List<MovieEntity>>> searchMovies(
    String query, {
    int page = 1,
  });

  Future<Either<Failure, List<MovieEntity>>> getPopularMovies({int page = 1});
}
