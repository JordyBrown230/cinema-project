import 'dart:convert';
import 'package:project/constants.dart';
import 'package:project/models/movie.dart';
import 'package:http/http.dart' as http;

class API {
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(
        Uri.parse('${Constants.baseUrl}/3/movie/upcoming?api_key=${Constants.apiKey}'));
    if (response.statusCode == 200) {
      try {
        final decodedData = jsonDecode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load upcoming movies: ${response.statusCode}');
    }
  }
}
