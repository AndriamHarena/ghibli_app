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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Colonne de gauche : Image
              Expanded(
                flex: 1,
                child: _buildImageColumn(movie),
              ),
              const SizedBox(width: 16),
              // Colonne de droite : Informations
              Expanded(
                flex: 2,
                child: _buildInfoColumn(movie),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageColumn(Movie movie) {
    return Column(
      children: [
        if (movie.image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.image!,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 300,
              errorBuilder: (context, error, stackTrace) => 
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.broken_image, 
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
            ),
          )
        else
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.movie, 
              size: 60,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoColumn(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre principal
        Text(
          movie.title ?? 'Titre non disponible',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Titre original
        if (movie.original_title != null && movie.original_title!.isNotEmpty)
          Text(
            'Titre original: ${movie.original_title}',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        
        const SizedBox(height: 4),
        
        // Titre original romanisé
        if (movie.original_title_romanised != null && movie.original_title_romanised!.isNotEmpty)
          Text(
            'Titre romanisé: ${movie.original_title_romanised}',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        
        const SizedBox(height: 16),
        
        // Note sous forme d'étoiles
        if (movie.rt_score != null)
          Row(
            children: [
              const Text(
                'Note: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              RatingStars(
                value: double.tryParse(movie.rt_score!) != null 
                    ? (double.parse(movie.rt_score!) / 100) * 5 
                    : 0.0,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 20,
                ),
                starCount: 5,
                starSize: 20,
                starSpacing: 2,
                maxValue: 5,
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.amber,
                // showRatingValue: false,
              ),
            ],
          ),
        
        const SizedBox(height: 16),
        
        // Description
        if (movie.description != null && movie.description!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                movie.description!,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        
        const SizedBox(height: 20),
        
        // Informations techniques
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informations techniques',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                
                if (movie.director != null && movie.director!.isNotEmpty)
                  _buildInfoRow('Réalisateur', movie.director!),
                
                if (movie.producer != null && movie.producer!.isNotEmpty)
                  _buildInfoRow('Producteur', movie.producer!),
                
                if (movie.release_date != null && movie.release_date!.isNotEmpty)
                  _buildInfoRow('Date de sortie', movie.release_date!),
                
                if (movie.running_time != null && movie.running_time!.isNotEmpty)
                  _buildInfoRow('Durée', '${movie.running_time} minutes'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}