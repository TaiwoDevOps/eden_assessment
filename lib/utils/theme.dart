import 'package:flutter/material.dart';

// app theme
final baseTheme = ThemeData.light();

// theme
final ThemeData appTheme = baseTheme.copyWith(
  primaryColor: appColors.secondaryGreen,
  appBarTheme: AppBarTheme(
    backgroundColor: appColors.white,
    elevation: 0,
  ),
  colorScheme: baseTheme.colorScheme.copyWith(
    secondary: appColors.primaryGreen,
  ),
  scaffoldBackgroundColor: appColors.white,
  brightness: Brightness.light,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    linearTrackColor: appColors.primaryGreen,
    circularTrackColor: appColors.secondaryGreen.withOpacity(.1),
    color: appColors.secondaryGreen,
  ),
  buttonTheme: baseTheme.copyWith().buttonTheme.copyWith(
        buttonColor: appColors.secondaryGreen,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
  primaryIconTheme: baseTheme.primaryIconTheme.copyWith(
    color: appColors.secondaryGreen,
  ),
  iconTheme: baseTheme.iconTheme.copyWith(
    color: appColors.secondaryGreen,
  ),
);

// app colors
const appColors = ThemeModel(
  primaryGreen: Color(0xFF03a84e),
  // deepGreen: Color.fromARGB(255, 1, 49, 23),
  deepGreen: Color(0xFF013117),
  secondaryGreen: Color(0xFF14b757),
  tertiaryGreen: Color(0xFF6ece8a),
  white: Color(0xFFFFFFFF),
  error: Color(0xFFFF0000),
  warning: Color(0xFF808080),
  black: Color(0xFF000000),
);

// theme model
class ThemeModel {
  const ThemeModel({
    required this.primaryGreen,
    required this.secondaryGreen,
    required this.deepGreen,
    required this.tertiaryGreen,
    required this.white,
    required this.error,
    required this.warning,
    required this.black,
  });

  final Color primaryGreen;
  final Color deepGreen;
  final Color secondaryGreen;
  final Color tertiaryGreen;
  final Color white;
  final Color error;
  final Color warning;
  final Color black;
}
