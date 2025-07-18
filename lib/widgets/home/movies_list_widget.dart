// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghibli/models/movie.dart';
import 'package:ghibli/services/movies_api_service.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {

    // inspect(MoviesApiService().getMovies());

    return Column (
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Movies', 
              style: GoogleFonts.quicksand(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E2E2E),
              ),
            ),
          ),

          FutureBuilder(future: MoviesApiService().getMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Movie> movies = snapshot.requireData;
                // inspect(movies);
                return ListView.builder(
                  shrinkWrap: true,
                  
                  itemCount: movies.length,

                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.0),
                          onTap: () => context.go('/movie/${movies[index].id}'),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                // Movie banner with rounded corners and shadow
                                SizedBox(
                                  width: 70,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        movies[index].movie_banner!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFA4C3B2).withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: const Icon(
                                            Icons.broken_image, 
                                            size: 24,
                                            color: Color(0xFFA4C3B2),
                                          ),
                                        ),    
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                // Title and subtitle
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        movies[index].title!,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF2E2E2E),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        movies[index].original_title!,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF2E2E2E).withOpacity(0.7),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                // Chevron icon
                                Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA4C3B2).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFFA4C3B2),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
              },);
            }
              return Container(
                padding: const EdgeInsets.all(32.0),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA4C3B2)),
                ),
              );
            }
          )
        ],
    );
  }
}  
