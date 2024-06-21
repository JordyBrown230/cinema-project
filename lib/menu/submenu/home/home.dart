import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/home/ListViewDiscoverMovies/discoverMovies.dart';
import 'package:project/home/ListViewUpcomingMovies/upcomingMovies.dart';
import 'package:project/home/carrousel/carrousel.dart';
import 'package:project/api/api.dart';
import 'package:project/menu/menu_bar.dart';
import 'package:project/models/movie.dart';
import 'package:project/theme/app_theme.dart';

import 'results_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];
  final API _api = API();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String searchText) async {
    try {
      List<Movie> movies = await _api.searchMovies(searchText);
      setState(() {
        _searchResults = movies;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error al buscar las peliculas: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFF382C3E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Buscar',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5, right: 10),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 40, maxHeight: 24),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onChanged: (value) {
                        _performSearch(value);
                      },
                    ),
                  ),
                ),
                _searchResults.isNotEmpty
                    ? ResultsMovies(searchResults: _searchResults)
                    : const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          Carrousel(),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          UpComingMovies(),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          DiscoverMovies(),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
