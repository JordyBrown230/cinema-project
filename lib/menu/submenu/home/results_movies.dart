import 'package:flutter/material.dart';
import 'package:project/MovieDetails/movie_details.dart';
import 'package:project/variables.dart';
import 'package:project/models/movie.dart';

class ResultsMovies extends StatelessWidget {
  const ResultsMovies({
    super.key,
    required this.searchResults,
  });

  final List<Movie> searchResults;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(
              searchResults[index].title,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(searchResults[index].releaseDate,
                style: const TextStyle(color: Colors.white)),
            leading: searchResults[index].posterPath != null
                ? Image.network(
                    '${Variables.imagePath}${searchResults[index].posterPath}')
                : Container(width: 50, height: 50, color: Colors.grey),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailsScreen(movie: searchResults[index])));
          },
        );
      },
    );
  }
}
