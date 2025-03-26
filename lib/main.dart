import 'dart:html';

import 'package:flutter/material.dart';
import 'package:movie_app/providers/app_theme_provider.dart';
import 'package:movie_app/providers/movie_providers.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          // ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ],
        child: HomeScreen(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        return MaterialApp(
          title: 'Movies',
          debugShowCheckedModeBanner: false,
          theme: movieProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: HomeScreen(),
        );
      }
    );
  }
}