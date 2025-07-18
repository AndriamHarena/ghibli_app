// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghibli/widgets/movie/movie_widget.dart';
import 'package:ghibli/widgets/shared/appbar_widget.dart';
// import 'package:ghibli/widgets/shared/appbar_widget.dart';

class MovieScreen extends StatelessWidget {

final String? id;

const MovieScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // print('Movie ID: $id');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Ghibli_sky.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // AppBar content integrated
            const AppbarWidget(showBackButton: true),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: MovieWidget(id: id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}