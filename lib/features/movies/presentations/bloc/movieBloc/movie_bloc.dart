import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio_rest_api/features/movies/domain/repositories/movie_repository.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_events.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_states.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitialState()) {
    on<FetchUpcomingMoviesEvent>(_onFetchUpcomingMovies);
    on<FetchMovieDetailsEvent>(_onFetchMovieDetails);
    on<FetchMovieVideosEvent>(_onFetchMovieVideos);
    on<SearchMoviesEvent>(_onSearchMovies);
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
  }

  Future<void> _onFetchUpcomingMovies(
    FetchUpcomingMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoadingState());
    final result = await movieRepository.getUpcomingMovies(page: event.page);
    result.fold(
      (failure) => emit(MovieErrorState(message: failure.message)),
      (movies) => emit(MovieLoadedState(movies: movies)),
    );
  }

  Future<void> _onFetchMovieDetails(
    FetchMovieDetailsEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieDetailLoadingState());
    final result = await movieRepository.getMovieDetails(event.movieId);
    result.fold(
      (failure) => emit(MovieErrorState(message: failure.message)),
      (movie) => emit(MovieDetailLoadedState(movie: movie)),
    );
  }

  Future<void> _onFetchMovieVideos(
    FetchMovieVideosEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieVideosLoadingState());
    final result = await movieRepository.getMovieVideos(event.movieId);
    result.fold(
      (failure) => emit(MovieErrorState(message: failure.message)),
      (videos) => emit(MovieVideosLoadedState(videos: videos)),
    );
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieSearchLoadingState());
    final result = await movieRepository.searchMovies(event.query, page: event.page);
    result.fold(
      (failure) => emit(MovieErrorState(message: failure.message)),
      (movies) => emit(MovieSearchLoadedState(movies: movies)),
    );
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieSearchLoadingState());
    final result = await movieRepository.getPopularMovies(page: event.page);
    result.fold(
      (failure) => emit(MovieErrorState(message: failure.message)),
      (movies) => emit(PopularMoviesLoadedState(movies: movies)),
    );
  }
}
