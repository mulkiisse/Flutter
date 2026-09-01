import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryGreen = Color(0xFFB6F500);
const Color incomeGreen = Color(0xFF3DDC84);
const Color expenseRed = Color(0xFFFF4C4C);
const Color cardLightGreen = Color(0xFFE4F5D8);
const Color cardPeach = Color(0xFFFBEAE0);
const Color purpleGradientStart = Color(0xFF6A5AE0);
const Color greyText = Color(0xFF9E9E9E);

const Color surfaceDark = Color(0xFF1B1B1B);
const Color cardDark = Color(0xFF252525);
const Color whiteText = Colors.white;

const double cardRadius = 24;
const double pillRadius = 30;

/// Global Material 3 theme and reusable visual constants for MoneyTrack.
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryGreen,
    brightness: Brightness.dark,
  ).copyWith(
    primary: primaryGreen,
    secondary: incomeGreen,
    error: expenseRed,
    surface: surfaceDark,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark().textTheme,
  ).apply(
    bodyColor: whiteText,
    displayColor: whiteText,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: cardDark,
    hintStyle: const TextStyle(color: greyText),
    labelStyle: const TextStyle(color: greyText),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: primaryGreen, width: 1.2),
    ),
  ),
);
