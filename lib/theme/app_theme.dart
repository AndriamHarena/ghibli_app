import 'package:flutter/material.dart';

class AppTheme {
  /*
    visibilité en dart: uniquement public et private
    pas de mot clé public ou private
    pour créer un membre privée, préfixer le nom par un tiret du bas _
  */

  ThemeData getTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'RedditSansCondensed',
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          fontFamily: 'RedditSansCondensed',
          fontSize: 21,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}