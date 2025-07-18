import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /*
    visibilité en dart: uniquement public et private
    pas de mot clé public ou private
    pour créer un membre privée, préfixer le nom par un tiret du bas _
  */

  ThemeData getTheme() {
    return ThemeData(
      // Studio Ghibli beige background
      scaffoldBackgroundColor: const Color(0xFFFDF6EC),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.quicksand(
          fontWeight: FontWeight.w400,
          color: const Color(0xFF2E2E2E),
        ),
        titleMedium: GoogleFonts.quicksand(
          fontSize: 21,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF2E2E2E),
        ),
        headlineLarge: GoogleFonts.quicksand(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2E2E2E),
        ),
        headlineMedium: GoogleFonts.quicksand(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2E2E2E),
        ),
        bodyLarge: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2E2E2E),
        ),
        bodySmall: GoogleFonts.quicksand(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF2E2E2E).withOpacity(0.7),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFA4C3B2), // Studio Ghibli sage green
        brightness: Brightness.light,
        surface: const Color(0xFFFDF6EC), // Studio Ghibli beige
      ),
    );
  }
}