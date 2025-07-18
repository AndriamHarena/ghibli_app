import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghibli/screens/home_screen.dart';
import 'package:ghibli/screens/movie_screen.dart';
import 'package:go_router/go_router.dart';

class RouterService {

  GoRouter getrouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/', 
          name: 'home',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),

        GoRoute(
          path: '/movie/:id', 
          name: 'movie',
          pageBuilder: (context, state) {
            inspect(state.pathParameters['id']);
            return CustomTransitionPage(
              key: state.pageKey,
              child: MovieScreen(id: state.pathParameters['id']),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );
  }
}