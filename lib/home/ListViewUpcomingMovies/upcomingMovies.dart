import 'package:flutter/material.dart';
import 'package:project/api/api.dart';
import 'package:project/models/movie.dart';

class UpComingMovies extends StatefulWidget {
  const UpComingMovies({super.key});

  @override
  State<UpComingMovies> createState() => _UpComingMoviesState();
}

class _UpComingMoviesState extends State<UpComingMovies> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = API().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Próximas Películas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<Movie>>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay películas próximas.'));
            } else {
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _buildCard(snapshot.data![index]);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildCard(Movie movie) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
