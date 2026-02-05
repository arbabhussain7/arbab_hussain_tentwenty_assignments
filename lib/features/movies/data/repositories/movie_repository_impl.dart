import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_rest_api/core/errors/failures.dart';
import 'package:dio_rest_api/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/features/movies/domain/entities/video_entity.dart';
import 'package:dio_rest_api/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies({
    int page = 1,
  }) async {
    try {
      final movieModels = await remoteDataSource.getUpcomingMovies(page: page);
      final movieEntities = movieModels
          .map((model) => model.toEntity())
          .toList();
      return Right(movieEntities);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(e.response?.data['message'] ?? 'Server error occurred'),
        );
      } else {
        return Left(NetworkFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(int movieId) async {
    try {
      final movieModel = await remoteDataSource.getMovieDetails(movieId);
      return Right(movieModel.toEntity());
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(e.response?.data['message'] ?? 'Server error occurred'),
        );
      } else {
        return Left(NetworkFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getMovieVideos(int movieId) async {
    try {
      final videoModels = await remoteDataSource.getMovieVideos(movieId);
      final videoEntities = videoModels
          .map((model) => model.toEntity())
          .toList();
      return Right(videoEntities);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(e.response?.data['message'] ?? 'Server error occurred'),
        );
      } else {
        return Left(NetworkFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(
    String query, {
    int page = 1,
  }) async {
    try {
      final movieModels = await remoteDataSource.searchMovies(
        query,
        page: page,
      );
      final movieEntities = movieModels
          .map((model) => model.toEntity())
          .toList();
      return Right(movieEntities);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(e.response?.data['message'] ?? 'Server error occurred'),
        );
      } else {
        return Left(NetworkFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies({
    int page = 1,
  }) async {
    try {
      final movieModels = await remoteDataSource.getPopularMovies(page: page);
      final movieEntities = movieModels
          .map((model) => model.toEntity())
          .toList();
      return Right(movieEntities);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(
          ServerFailure(e.response?.data['message'] ?? 'Server error occurred'),
        );
      } else {
        return Left(NetworkFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
