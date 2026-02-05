// ignore_for_file: deprecated_member_use

import 'package:dio_rest_api/features/movies/presentations/bloc/BottomNavBarBloc/bottom_nav_bar_bloc.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/BottomNavBarBloc/bottom_nav_bar_events.dart';
import 'package:dio_rest_api/features/movies/presentations/bloc/BottomNavBarBloc/bottom_nav_bar_state.dart';
import 'package:dio_rest_api/utils/app_assets.dart';
import 'package:dio_rest_api/utils/app_colord.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationBloc(),
      child: const BottomNavBarView(),
    );
  }
}

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return context
              .read<BottomNavigationBloc>()
              .widgetList[state.selectedIndex];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 9.v, horizontal: 12.h),

                decoration: BoxDecoration(
                  color: darkBlackColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33.adaptSize),
                    topRight: Radius.circular(33.adaptSize),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(0),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.dashboardIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 0
                                  ? whiteColor
                                  : greyColor,
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Dashboard',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 0
                                    ? whiteColor
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Classes Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(1),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.watchIcons,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 1
                                  ? whiteColor
                                  : greyColor,
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Watch',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 1
                                    ? whiteColor
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Material Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(2),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.mediaLiberyIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 2
                                  ? whiteColor
                                  : greyColor,
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Media Library',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 2
                                    ? whiteColor
                                    : transparentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Grades Nav Item
                    GestureDetector(
                      onTap: () => context.read<BottomNavigationBloc>().add(
                        NavigationTabChanged(3),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.v,
                          horizontal: 18.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.moreIcon,
                              width: 24.h,
                              height: 24.v,
                              color: state.selectedIndex == 3
                                  ? whiteColor
                                  : greyColor,
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'More',
                              style: GoogleFonts.nunito(
                                fontSize: 12.adaptSize,
                                fontWeight: FontWeight.w400,
                                color: state.selectedIndex == 3
                                    ? whiteColor
                                    : Colors.transparent,
                              ),
                            ),
                          ],
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
