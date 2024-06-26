import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/MovieDetails/movie_details.dart';
import 'package:project/api/api.dart';
import 'package:project/variables.dart';
import 'package:project/models/movie.dart';

class Carrousel extends StatefulWidget {
  const Carrousel({super.key});

  @override
  State<Carrousel> createState() => _CarrouselState();
}

class _CarrouselState extends State<Carrousel> {
  late Future<List<Movie>> upComingMovies;

  @override
  void initState() {
    super.initState();
    upComingMovies = API().getMoviesOnTheaters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 15),
      child: FutureBuilder<List<Movie>>(
        future: upComingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay datos disponibles'),
            );
          } else {
            List<Movie> movies = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Películas en cartelera',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 0.51, 
                    height: 300,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                  ),
                  items: movies.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(movie: movie),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              '${Variables.imagePath}${movie.posterPath}',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 300, 
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

