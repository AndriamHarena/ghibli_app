import 'dart:convert';

import 'package:ghibli/models/movie.dart';
import 'package:http/http.dart' as http;

class MoviesApiService {

  Future<List<Movie>> getMovies() async {
    Uri uri = Uri.parse('https://ghibliapi.vercel.app/films');
    
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List json = await jsonDecode(response.body);
      List<Movie> results =json.map((data) {
        return Movie.fromJson(data);
      }).toList();

      return results;
    } 
      throw Error();
    }
  }