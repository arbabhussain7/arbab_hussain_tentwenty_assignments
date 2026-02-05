import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_rest_api/config/app_routes.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:dio_rest_api/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomMovieResult extends StatelessWidget {
  final List<MovieEntity> movies;

  const CustomMovieResult({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.v),
          child: Text(
            'No results found',
            style: AppTextStyle.iTextStyle.copyWith(color: bDarkBlackColor),
          ),
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.v),
          child: Text(
            '${movies.length} Results Found',
            style: AppTextStyle.eTextStyle.copyWith(
              color: bDarkBlackColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.fSize,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.watchDetailsScreen,
                  arguments: movie.id,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.v),
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.adaptSize),
                      child: movie.posterPath != null
                          ? CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              width: 130.h,
                              height: 100.v,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 130.h,
                                height: 100.v,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 130.h,
                                height: 100.v,
                                color: Colors.grey[300],
                                child: const Icon(Icons.error),
                              ),
                            )
                          : Container(
                              width: 130.h,
                              height: 100.v,
                              color: Colors.grey[300],
                              child: const Icon(Icons.movie, size: 40),
                            ),
                    ),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.eTextStyle.copyWith(
                              color: bDarkBlackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6.v),
                          Text(
                            movie.formattedReleaseDate,
                            style: AppTextStyle.iTextStyle.copyWith(
                              color: bDarkBlackColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_horiz, size: 28.adaptSize, color: blueColor),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 12.v);
          },
        ),
      ],
    );
  }
}
