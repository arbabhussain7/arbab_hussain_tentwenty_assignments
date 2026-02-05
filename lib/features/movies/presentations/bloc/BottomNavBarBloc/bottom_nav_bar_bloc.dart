import 'package:bloc/bloc.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/BottomNavBarBloc/bottom_nav_bar_events.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/BottomNavBarBloc/bottom_nav_bar_state.dart';
import 'package:dio_rest_api/features/movies/presentations/views/dashbaordScreen/dashboard_screen.dart';
import 'package:dio_rest_api/features/movies/presentations/views/mediaLiberyScreen/media_libery_screen.dart';
import 'package:dio_rest_api/features/movies/presentations/views/moreScreen/more_screen.dart';
import 'package:dio_rest_api/features/movies/presentations/views/watchScreen/watch_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final List<Widget> widgetList = [
    DashboardScreen(),
    WatchScreen(),
    MediaLiberyScreen(),
    MoreScreen(),
  ];

  BottomNavigationBloc() : super(const BottomNavigationState()) {
    on<NavigationTabChanged>(_onNavigationTabChanged);
  }

  void _onNavigationTabChanged(
    NavigationTabChanged event,
    Emitter<BottomNavigationState> emit,
  ) {
    if (event.tabIndex >= 0 && event.tabIndex < widgetList.length) {
      emit(state.copyWith(selectedIndex: event.tabIndex));
    }
  }
}
