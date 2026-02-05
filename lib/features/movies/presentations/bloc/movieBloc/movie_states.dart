import 'package:equatable/equatable.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/features/movies/domain/entities/video_entity.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<MovieEntity> movies;

  const MovieLoadedState({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class MovieErrorState extends MovieState {
  final String message;

  const MovieErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MovieVideosLoadingState extends MovieState {}

class MovieVideosLoadedState extends MovieState {
  final List<VideoEntity> videos;

  const MovieVideosLoadedState({required this.videos});

  @override
  List<Object?> get props => [videos];
}

class MovieDetailLoadingState extends MovieState {}

class MovieDetailLoadedState extends MovieState {
  final MovieEntity movie;

  const MovieDetailLoadedState({required this.movie});

  @override
  List<Object?> get props => [movie];
}

// Search states
class MovieSearchLoadingState extends MovieState {}

class MovieSearchLoadedState extends MovieState {
  final List<MovieEntity> movies;

  const MovieSearchLoadedState({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class PopularMoviesLoadedState extends MovieState {
  final List<MovieEntity> movies;

  const PopularMoviesLoadedState({required this.movies});

  @override
  List<Object?> get props => [movies];
}
