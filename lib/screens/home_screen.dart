import 'package:flutter/material.dart';
import 'package:ghibli/widgets/shared/appbar_widget.dart';
import 'package:ghibli/widgets/home/movies_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            AppbarWidget(),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: MoviesListWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}