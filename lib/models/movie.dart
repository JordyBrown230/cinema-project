class Movie {
  int id;
  String title;
  String? backDropPath;
  String overview;
  double popularity;
  String? posterPath;
  String releaseDate;
  double voteAverage;
  List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    this.backDropPath,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds, 
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<int> genreIds = List<int>.from(json['genre_ids']);

    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      backDropPath: json['backdrop_path'] as String?,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String,
      voteAverage: json['vote_average'] as double,
      genreIds: genreIds,
    );
  }
}
