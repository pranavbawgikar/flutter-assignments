// import 'package:flutter/material.dart';
//
// class AppThemeProvider with ChangeNotifier {
//   static final AppThemeProvider _instance = AppThemeProvider._internal();
//
//   factory AppThemeProvider() {
//     return _instance;
//   }
//
//   AppThemeProvider._internal();
//
//   bool isDarkMode = false;
//
//   Color get backgroundColor => isDarkMode ? Colors.black87 : Colors.white;
//
//   void switchDarkMode() {
//     isDarkMode = !isDarkMode;
//     notifyListeners();
//   }
//
//   // bool get isDarkMode => isDarkMode;
// }