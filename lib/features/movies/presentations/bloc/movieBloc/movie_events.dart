// lib/features/movies/presentations/bloc/movie_events.dart
import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchUpcomingMoviesEvent extends MovieEvent {
  final int page;

  const FetchUpcomingMoviesEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class FetchMovieDetailsEvent extends MovieEvent {
  final int movieId;

  const FetchMovieDetailsEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

// Fetch movie videos/trailers
class FetchMovieVideosEvent extends MovieEvent {
  final int movieId;

  const FetchMovieVideosEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

// Search movies
class SearchMoviesEvent extends MovieEvent {
  final String query;
  final int page;

  const SearchMoviesEvent({required this.query, this.page = 1});

  @override
  List<Object> get props => [query, page];
}

// Fetch popular movies
class FetchPopularMoviesEvent extends MovieEvent {
  final int page;

  const FetchPopularMoviesEvent({this.page = 1});

  @override
  List<Object> get props => [page];
}

