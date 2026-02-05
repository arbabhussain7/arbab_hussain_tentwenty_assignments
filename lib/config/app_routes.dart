import 'package:dio_rest_api/features/movies/presentations/views/bottomNavBar/bottom_nav_bar_screen.dart';
import 'package:dio_rest_api/features/movies/presentations/views/watchScreen/full_movie_screen.dart';
import 'package:dio_rest_api/features/movies/presentations/views/watchScreen/watch_details_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String bottomNavBarScreen = '/bottomNavBarScreen';
  static const String watchDetailsScreen = '/watchDetailsScreen';
  static const String fullMovieScreen = '/fullMovieScreen';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      bottomNavBarScreen: (context) => const BottomNavBarScreen(),
      watchDetailsScreen: (context) => const WatchDetailsScreen(),
      fullMovieScreen: (context) => const FullMovieScreen(),
    };
  }
}
