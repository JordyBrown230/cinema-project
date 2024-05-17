import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/api/api.dart';
import 'package:project/constants.dart';
import 'package:project/models/movie.dart';

// Ignore other imports...

late Future<List<Movie>> upComingMovies;

class Carrousel extends StatefulWidget {
  const Carrousel({Key? key}) : super(key: key);

  @override
  State<Carrousel> createState() => _CarrouselState();
}

class _CarrouselState extends State<Carrousel> {
  @override
  void initState() {
    super.initState();
    upComingMovies = API().getMoviesOnTheaters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter, // Alinea el carrusel en la parte superior
      margin: const EdgeInsets.only(top: 15), // Margen superior
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
                  'Próximas Películas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
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
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15), // Bordes redondeados
                          child: Image.network(
                            '${Constants.imagePath}${movie.posterPath}',
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            // Puedes ajustar el ancho según tus necesidades
                            width: MediaQuery.of(context).size.width,
                            height: 300, // Altura deseada
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
