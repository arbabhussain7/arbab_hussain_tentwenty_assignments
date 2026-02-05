import 'package:dio_rest_api/config/app_routes.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_bloc.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_events.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_states.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:dio_rest_api/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomListOfMovie extends StatefulWidget {
  const CustomListOfMovie({super.key});

  @override
  State<CustomListOfMovie> createState() => _CustomListOfMovieState();
}

class _CustomListOfMovieState extends State<CustomListOfMovie> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const FetchUpcomingMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoadingState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.v),
              child: CircularProgressIndicator(color: blueColor),
            ),
          );
        } else if (state is MovieErrorState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.adaptSize),
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
                    'Error loading movies',
                    style: AppTextStyle.eTextStyle.copyWith(
                      color: bDarkBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.iTextStyle.copyWith(color: greyColor),
                  ),
                  SizedBox(height: 16.v),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MovieBloc>().add(
                        const FetchUpcomingMoviesEvent(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      foregroundColor: whiteColor,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else if (state is MovieLoadedState) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.adaptSize),
                child: Text(
                  'No movies available',
                  style: AppTextStyle.eTextStyle.copyWith(color: greyColor),
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: movies.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.watchDetailsScreen,
                    arguments: movie.id, // Pass movie ID
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.adaptSize),
                  child: Stack(
                    children: [
                      movie.fullBackdropPath != null
                          ? CachedNetworkImage(
                              imageUrl: movie.fullBackdropPath!,
                              height: 188.v,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height: 188.v,
                                width: double.infinity,
                                color: cLightWhiteColor,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: blueColor,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 188.v,
                                width: double.infinity,
                                color: cLightWhiteColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.movie,
                                      size: 50.adaptSize,
                                      color: greyColor,
                                    ),
                                    SizedBox(height: 8.v),
                                    Text(
                                      'No Image',
                                      style: AppTextStyle.iTextStyle.copyWith(
                                        color: greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 188.v,
                              width: double.infinity,
                              color: cLightWhiteColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.movie,
                                    size: 50.adaptSize,
                                    color: greyColor,
                                  ),
                                  SizedBox(height: 8.v),
                                  Text(
                                    'No Image',
                                    style: AppTextStyle.iTextStyle.copyWith(
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                transparentColor,
                                blackColor.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Movie title
                      Positioned(
                        left: 12.h,
                        bottom: 12.v,
                        right: 12.h,
                        child: Text(
                          movie.title,
                          style: AppTextStyle.nTextStyle.copyWith(
                            color: whiteColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 12.v);
            },
          );
        }

        // Initial state
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.v),
            child: CircularProgressIndicator(color: blueColor),
          ),
        );
      },
    );
  }
}
