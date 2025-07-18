import 'package:flutter/material.dart';
import 'package:ghibli/models/movie.dart';
import 'package:ghibli/services/movies_api_service.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class MovieWidget extends StatelessWidget {
  final String? id;
  
  const MovieWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const Center(
        child: Text('Aucun film sélectionné'),
      );
    }

    return FutureBuilder<List<Movie>>(
      future: MoviesApiService().getMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(
            child: Text('Erreur: ${snapshot.error}'),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Aucun film trouvé'),
          );
        }

        final movie = snapshot.data!.firstWhere(
          (movie) => movie.id == id,
          orElse: () => Movie(
            id: null,
            title: null,
            original_title: null,
            original_title_romanised: null,
            image: null,
            movie_banner: null,
            description: null,
            director: null,
            producer: null,
            release_date: null,
            running_time: null,
            rt_score: null,
          ),
        );

        if (movie.id == null) {
          return const Center(
            child: Text('Film non trouvé'),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Colonne de gauche : Image
                  Expanded(
                    flex: 1,
                    child: _buildImageColumn(movie),
                  ),
                  const SizedBox(width: 24),
                  // Colonne de droite : Informations
                  Expanded(
                    flex: 2,
                    child: _buildInfoColumn(context, movie),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageColumn(Movie movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
        child: movie.image != null
            ? Image.network(
                movie.image!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 400,
                errorBuilder: (context, error, stackTrace) => 
                  Container(
                    height: 400,
                    width: double.infinity,
                    color: const Color(0xFFF5F5F5),
                    child: const Icon(
                      Icons.broken_image, 
                      size: 60,
                      color: Color(0xFFA4C3B2),
                    ),
                  ),
              )
            : Container(
                height: 400,
                width: double.infinity,
                color: const Color(0xFFF5F5F5),
                child: const Icon(
                  Icons.movie, 
                  size: 60,
                  color: Color(0xFFA4C3B2),
                ),
              ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, Movie movie) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        // Titre principal
        Text(
          movie.title ?? 'Titre non disponible',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 24,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 12),
        

        
        // Note sous forme d'étoiles
        if (movie.rt_score != null)
          Row(
            children: [
              Text(
                'Note: ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              RatingStars(
                value: double.tryParse(movie.rt_score!) != null 
                    ? (double.parse(movie.rt_score!) / 100) * 5 
                    : 0.0,
                starBuilder: (index, color) => Icon(
                  Icons.star_rounded,
                  color: color,
                  size: 24,
                ),
                starCount: 5,
                starSize: 24,
                starSpacing: 3,
                maxValue: 5,
                starOffColor: const Color(0xFFA4C3B2).withOpacity(0.3),
                starColor: const Color(0xFFFFC107), // Studio Ghibli amber
              ),
            ],
          ),
        
        const SizedBox(height: 16),
        
        // Informations techniques
        if (movie.original_title != null && movie.original_title!.isNotEmpty)
          _buildInfoRow(context, 'Titre original', movie.original_title!),
        if (movie.original_title_romanised != null && movie.original_title_romanised!.isNotEmpty)
          _buildInfoRow(context, 'Romanisation', movie.original_title_romanised!),
        if (movie.director != null && movie.director!.isNotEmpty)
          _buildInfoRow(context, 'Réalisateur', movie.director!),
        if (movie.producer != null && movie.producer!.isNotEmpty)
          _buildInfoRow(context, 'Producteur', movie.producer!),
        if (movie.release_date != null && movie.release_date!.isNotEmpty)
          _buildInfoRow(context, 'Date de sortie', movie.release_date!),
        if (movie.running_time != null && movie.running_time!.isNotEmpty)
          _buildInfoRow(context, 'Durée', '${movie.running_time} minutes'),
        
        const SizedBox(height: 16),
        
        // Description
        if (movie.description != null && movie.description!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description :',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                movie.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),

      ],
    )
  );
}

Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}