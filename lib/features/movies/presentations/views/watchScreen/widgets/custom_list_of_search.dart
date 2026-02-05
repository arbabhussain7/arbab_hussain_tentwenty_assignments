import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_rest_api/config/app_routes.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:dio_rest_api/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomListOfSearch extends StatelessWidget {
  final List<MovieEntity> movies;

  const CustomListOfSearch({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Text(
          'No movies found',
          style: AppTextStyle.iTextStyle.copyWith(color: bDarkBlackColor),
        ),
      );
    }
    
    return GridView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.7,
        crossAxisSpacing: 8.h,
        mainAxisSpacing: 8.v,
      ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.adaptSize),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (movie.backdropPath != null)
                  CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                    width: 163.h,
                    height: 100.v,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  )
                else
                  Container(
                    color: Colors.grey,
                    child: const Icon(Icons.movie),
                  ),
                Positioned(
                  left: 12.h,
                  bottom: 12.v,
                  right: 12.h,
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.nTextStyle.copyWith(
                      color: whiteColor,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 1),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
