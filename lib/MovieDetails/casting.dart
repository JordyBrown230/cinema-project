import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cast_card.dart';
import 'package:project/api/api.dart';

class MovieCastWidget extends StatefulWidget {
  final int movieId;
  const MovieCastWidget({super.key, required this.movieId});

  @override
  MovieCastWidgetState createState() => MovieCastWidgetState();
}

class MovieCastWidgetState extends State<MovieCastWidget> {
  List<dynamic> cast = [];

  @override
  void initState() {
    super.initState();
    fetchCast();
  }

  Future<void> fetchCast() async {
    try {
      List<dynamic> fetchedCast = await API().fetchCast(widget.movieId);
      setState(() {
        cast = fetchedCast;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return cast.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 250, 
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cast.map((actor) {
                  return CastCard(
                    name: actor['name'],
                    profilePath: actor['profile_path'],
                    character: actor['character'],
                  );
                }).toList(),
              ),
            ),
          );
  }
}
