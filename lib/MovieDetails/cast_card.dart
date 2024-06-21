import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class CastCard extends StatelessWidget {
  final String name;
  final String? profilePath;
  final String character;

  const CastCard({super.key, required this.name, this.profilePath, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: profilePath != null
                ? Image.network(
                    '${Constants.imagePath}$profilePath',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 160,
                  )
                : Container(
                    width: 100,
                    height: 150,
                    color: Colors.grey,
                  ),
          ),
          const SizedBox(height: 8.0),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          Text(
            character,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
