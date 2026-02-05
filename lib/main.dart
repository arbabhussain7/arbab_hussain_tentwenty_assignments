import 'package:dio_rest_api/config/app_routes.dart';
import 'package:dio_rest_api/config/routes_observer.dart';
import 'package:dio_rest_api/utils/app_size.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          navigatorObservers: [routeObserver],
          initialRoute: AppRoutes.bottomNavBarScreen,
          routes: AppRoutes.getRoutes(),
        );
      },
    );
  }
}
