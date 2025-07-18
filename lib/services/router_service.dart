import 'dart:developer';

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
          builder: (context, state) => HomeScreen(),
        ),

        GoRoute(
          path: '/movie/:id', 
          name: 'movie',
          builder: (context, state) {
            inspect(state.pathParameters['id']);
            return MovieScreen(id: state.pathParameters['id']);
          } 
        ),
      ],
    );
  }
}