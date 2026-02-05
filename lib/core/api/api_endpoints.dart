class ApiEndpoints {
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbApiKey = '9c7e22e44d450159b72798a46d368500';
  
  static const String upcomingMovies = '/movie/upcoming';
  static const String popularMovies = '/movie/popular';
  static String movieDetails(int movieId) => '/movie/$movieId';
  
  static String searchMovies(String query, {int page = 1}) =>
      '/search/movie?api_key=$tmdbApiKey&language=en-US&query=$query&page=$page&include_adult=false';
  
  static String movieVideos(int movieId) =>
      '/movie/$movieId/videos?api_key=$tmdbApiKey&language=en-US';
  static String movieImages(int movieId) =>
      '/movie/$movieId/images?api_key=$tmdbApiKey';
}
