import 'dart:async';
import 'package:dio_rest_api/core/api/api_client.dart';
import 'package:dio_rest_api/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:dio_rest_api/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:dio_rest_api/features/movies/domain/entities/movie_entity.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_bloc.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_events.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/movieBloc/movie_states.dart';
import 'package:dio_rest_api/features/movies/presentations/views/watchScreen/widgets/custom_list_of_search.dart';
import 'package:dio_rest_api/features/movies/presentations/views/watchScreen/widgets/custom_movie_list.dart';
import 'package:dio_rest_api/features/movies/presentations/views/watchScreen/widgets/custom_movie_result.dart';
import 'package:dio_rest_api/utils/app_assets.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:dio_rest_api/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  bool isSearchOpen = false;
  final TextEditingController _searchController = TextEditingController();
  bool hasSearchText = false;
  Timer? _debounce;
  
  // Local state to hold API data
  List<MovieEntity> popularMovies = [];
  List<MovieEntity> searchResults = [];
  bool isLoading = false;

  late MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    
    // Initialize dependencies and Bloc
    final apiClient = ApiClient();
    final movieRemoteDataSource = MovieRemoteDataSourceImpl(
      apiClient: apiClient,
    );
    final movieRepository = MovieRepositoryImpl(
      remoteDataSource: movieRemoteDataSource,
    );
    
    _movieBloc = MovieBloc(movieRepository: movieRepository);
    
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      hasSearchText = _searchController.text.isNotEmpty;
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    if (hasSearchText) {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _movieBloc.add(
          SearchMoviesEvent(query: _searchController.text),
        );
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _movieBloc,
      child: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is PopularMoviesLoadedState) {
            setState(() {
              popularMovies = state.movies;
              isLoading = false;
            });
          } else if (state is MovieSearchLoadedState) {
            setState(() {
              searchResults = state.movies;
              isLoading = false;
            });
          } else if (state is MovieSearchLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is MovieErrorState) {
            setState(() {
               isLoading = false;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: aDarkBlackColor.withOpacity(0.1),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 33.v),
                  decoration: BoxDecoration(color: whiteColor),
                  child: Padding(
                    padding: EdgeInsets.only(top: 22.v),
                    child: Stack(
                      children: [
                        if (!isSearchOpen)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Watch',
                                style: AppTextStyle.cTextStyle.copyWith(
                                  color: bDarkBlackColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSearchOpen = true;
                                  });
                                  // Fetch popular movies when search opens
                                  _movieBloc.add(
                                    const FetchPopularMoviesEvent(),
                                  );
                                },
                                child: SvgPicture.asset(AppAssets.searchIcon),
                              ),
                            ],
                          ),

                        if (isSearchOpen)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.h,
                              vertical: 6.v,
                            ),
                            decoration: BoxDecoration(
                              color: bLightWhiteColor,
                              borderRadius: BorderRadius.circular(30.adaptSize),
                              border: Border.all(color: cLightWhiteColor),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppAssets.searchIcon),
                                SizedBox(width: 12.h),
                                Expanded(
                                  child: TextFormField(
                                    controller: _searchController,
                                    autofocus: true,
                                    style: AppTextStyle.eTextStyle.copyWith(
                                      color: bDarkBlackColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'TV shows, movies and more',
                                      hintStyle: AppTextStyle.iTextStyle.copyWith(
                                        color: bDarkBlackColor.withAlpha(30),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSearchOpen = false;
                                      _searchController.clear();
                                      hasSearchText = false;
                                      searchResults = [];
                                    });
                                  },
                                  child: Icon(Icons.close, color: bDarkBlackColor),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isSearchOpen && hasSearchText) ...[
                            SizedBox(height: 16.v),
                            Text(
                              'Top Results',
                              style: AppTextStyle.eTextStyle.copyWith(
                                color: bDarkBlackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.v),
                          ],

                          if (isLoading)
                             Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.adaptSize),
                                child: CircularProgressIndicator(color: blueColor),
                              ),
                            )
                          else if (!isSearchOpen)
                            CustomListOfMovie()
                          else if (hasSearchText)
                            CustomMovieResult(movies: searchResults)
                          else
                            CustomListOfSearch(movies: popularMovies),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
