import 'dart:convert';
import 'package:project/constants.dart';
import 'package:project/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/review.dart';

class API {
  Future<List<Movie>> getMoviesOnTheaters() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/movie/now_playing?api_key=${Constants.apiKey}&&language=es'));
    if (response.statusCode == 200) {
      try {
        final decodedData = jsonDecode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception(
          'Failed to load movies on theaters: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/movie/upcoming?api_key=${Constants.apiKey}&&language=es'));
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

  Future<List<Movie>> getDiscoverMovies() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/discover/movie?api_key=${Constants.apiKey}&&language=es'));
    if (response.statusCode == 200) {
      try {
        final decodedData = jsonDecode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchCast(int movieId) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/movie/$movieId/credits?api_key=${Constants.apiKey}'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['cast'];
    } else {
      throw Exception('Failed to load cast');
    }
  }

  Future<List<Movie>> searchMovies(String nombre) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/search/movie?api_key=${Constants.apiKey}&query=$nombre&&language=es'));
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body)['results'] as List;
        return data.map((movie) => Movie.fromJson(movie)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getByGender(int gender) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/discover/movie?api_key=${Constants.apiKey}&with_genres=$gender&&language=es'));
    if (response.statusCode == 200) {
      try {
        final decodedData = jsonDecode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<List<Movie>> similars(int movieId) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/movie/$movieId/recommendations?api_key=${Constants.apiKey}&&language=es'));
    if (response.statusCode == 200) {
      try {
        final decodedData = jsonDecode(response.body)['results'] as List;
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<List<Review>> getReviews(int movieId) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/3/movie/$movieId/reviews?api_key=${Constants.apiKey}&&language=es'));
    if (response.statusCode == 200) {
      try {
        final decodedData = jsonDecode(response.body)['results'] as List;
        return decodedData.map((review) => Review.fromJson(review)).toList();
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<String?> fetchTrailerKey(int movieId) async {
    try {
      final trailerUrl =
          'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=${Constants.apiKey}';

      final response = await http.get(Uri.parse(trailerUrl));
      if (response.statusCode == 200) {
        final videoData = json.decode(response.body)['results'];
        if (videoData.isNotEmpty) {
          final videoKey = videoData[0]['key'];
          return videoKey;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
