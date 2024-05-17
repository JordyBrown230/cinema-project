import 'package:flutter/material.dart';
import 'package:project/home/ListViewUpcomingMovies/upcomingMovies.dart';
import 'package:project/home/carrousel/carrousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Carrousel(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Expanded(
            child: UpComingMovies(),
          ),
        ],
      ),
    );
  }
}
