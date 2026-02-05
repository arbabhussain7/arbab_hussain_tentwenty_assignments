import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_rest_api/config/app_routes.dart';
import 'package:dio_rest_api/core/api/api_client.dart';
import 'package:dio_rest_api/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:dio_rest_api/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/features/movies/domain/entities/video_entity.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_bloc.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_events.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_states.dart';
import 'package:dio_rest_api/features/movies/presentations/widgets/trailer_dialog.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_list.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:dio_rest_api/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchDetailsScreen extends StatefulWidget {
  const WatchDetailsScreen({super.key});

  @override
  State<WatchDetailsScreen> createState() => _WatchDetailsScreenState();
}

class _WatchDetailsScreenState extends State<WatchDetailsScreen> {
  MovieEntity? _cachedMovie;
  List<VideoEntity> _cachedVideos = [];

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as int?;

    return BlocProvider(
      create: (context) {
        final apiClient = ApiClient();
        final movieRemoteDataSource = MovieRemoteDataSourceImpl(
          apiClient: apiClient,
        );
        final movieRepository = MovieRepositoryImpl(
          remoteDataSource: movieRemoteDataSource,
        );
        final bloc = MovieBloc(movieRepository: movieRepository);
        if (movieId != null) {
          bloc.add(FetchMovieDetailsEvent(movieId: movieId));
          bloc.add(FetchMovieVideosEvent(movieId: movieId));
        }

        return bloc;
      },
      child: Scaffold(
        body: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieDetailLoadedState) {
              setState(() {
                _cachedMovie = state.movie;
              });
            }
            if (state is MovieVideosLoadedState) {
              setState(() {
                _cachedVideos = state.videos;
              });
            }
          },
          builder: (context, state) {
            if (state is MovieDetailLoadingState && _cachedMovie == null) {
              return Center(child: CircularProgressIndicator(color: blueColor));
            } else if (state is MovieErrorState && _cachedMovie == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60.adaptSize,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16.v),
                    Text(
                      'Error loading movie details',
                      style: AppTextStyle.eTextStyle.copyWith(
                        color: bDarkBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.iTextStyle.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.v),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        foregroundColor: whiteColor,
                      ),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }
            // Show movie details if we have cached movie
            else if (_cachedMovie != null) {
              final movie = _cachedMovie!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie poster with gradient overlay
                    Stack(
                      children: [
                        // Movie Poster
                        CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: double.infinity,
                          height: 512.v,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 375.v,
                            color: Colors.grey[300],
                            child: Center(
                              child: CircularProgressIndicator(
                                color: blueColor,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 375.v,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        ),

                        // Gradient Overlay
                        Container(
                          width: double.infinity,
                          height: 512.v,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                blackColor.withOpacity(0.7),
                                blackColor,
                              ],
                            ),
                          ),
                        ),

                        // Back Button
                        Positioned(
                          top: 40.v,
                          left: 20.h,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(8.adaptSize),
                              decoration: BoxDecoration(
                                color: blackColor.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: whiteColor,
                                size: 24.adaptSize,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 331.v,
                          left: 89.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'In Theaters ${movie.formattedReleaseDate}',
                                style: AppTextStyle.cTextStyle.copyWith(
                                  color: whiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12.v),

                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12.adaptSize,
                                    ),
                                  ),
                                  fixedSize: Size(251.h, 55.v),
                                ),
                                child: Text(
                                  'Get Tickets',
                                  style: AppTextStyle.cTextStyle.copyWith(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.v),

                              _buildTrailerButton(state),
                              SizedBox(height: 16.v),

                              // Get Tickets Button
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyle.cTextStyle.copyWith(
                              color: blackColor,
                              fontSize: 24.fSize,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.v),
                          if (movie.genres != null && movie.genres!.isNotEmpty)
                            SizedBox(
                              height: 30.v, // IMPORTANT: give height
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: movie.genres!.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 8.h),
                                itemBuilder: (context, index) {
                                  final genre = movie.genres![index];

                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.h,
                                      vertical: 6.v,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorsList[index],
                                      borderRadius: BorderRadius.circular(
                                        20.adaptSize,
                                      ),
                                    ),
                                    child: Text(
                                      genre.name,
                                      style: AppTextStyle.iTextStyle.copyWith(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: 12.v),
                          Divider(color: aWhiteColor),
                          SizedBox(height: 12.v),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overview',
                                style: AppTextStyle.cTextStyle.copyWith(
                                  color: blackColor,
                                ),
                              ),
                              SizedBox(height: 8.v),
                              Text(
                                movie.overview,
                                style: AppTextStyle.iTextStyle.copyWith(
                                  color: greyColor,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.v),
                  ],
                ),
              );
            }

            // Default loading state
            return Center(
              child: CircularProgressIndicator(color: blueColor),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTrailerButton(MovieState state) {
    final trailers = _cachedVideos
        .where(
          (v) =>
              v.site == 'YouTube' &&
              (v.type == 'Trailer' || v.type == 'Teaser'),
        )
        .toList();

    final isLoading = state is MovieVideosLoadingState;

    return ElevatedButton(
      onPressed: trailers.isNotEmpty
          ? () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return TrailerDialog(
                    video: trailers.first,
                    onFullScreen: () {
                      // Navigate to fullscreen
                      Navigator.pushNamed(
                        context,
                        AppRoutes.fullMovieScreen,
                        arguments: trailers.first,
                      );
                    },
                  );
                },
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: transparentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.adaptSize),
          side: BorderSide(color: blueColor),
        ),
        fixedSize: Size(251.h, 55.v),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow, color: whiteColor),
          SizedBox(width: 6.h),
          Text(
            isLoading
                ? 'Loading...'
                : trailers.isEmpty
                ? 'No Trailer'
                : 'Watch Trailer',
            style: AppTextStyle.cTextStyle.copyWith(color: whiteColor),
          ),
        ],
      ),
    );
  }
}
