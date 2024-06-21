import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/api/api.dart';
import 'package:project/models/review.dart';

class MovieReviews extends StatefulWidget {
  final int movieId;
  const MovieReviews({super.key, required this.movieId});

  @override
  State<MovieReviews> createState() => _MovieReviewsState();
}

class _MovieReviewsState extends State<MovieReviews> {
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      List<Review> fetchedReviews = await API().getReviews(widget.movieId);
      setState(() {
        reviews = fetchedReviews;
      });
    } catch (e) {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (reviews.isNotEmpty) ...[
          const Text(
            'Reseñas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: reviews.map((review) {
                return ReviewWidget(review: review);
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}

class ReviewWidget extends StatefulWidget {
  final Review review;
  const ReviewWidget({super.key, required this.review});

  @override
  ReviewWidgetState createState() => ReviewWidgetState();
}

class ReviewWidgetState extends State<ReviewWidget> {
  bool isExpanded = false;
  static const int maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, 
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF382C3E),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: widget.review.authorDetails.avatarPath != null
                    ? NetworkImage('https://image.tmdb.org/t/p/w500${widget.review.authorDetails.avatarPath}')
                    : null,
                child: widget.review.authorDetails.avatarPath == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.review.author,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.review.content,
            maxLines: isExpanded ? null : maxLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          if (widget.review.content.length > 100)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'ver menos...' : 'ver más...',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
