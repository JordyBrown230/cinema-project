class Movie {
  int id;
  String title;
  String backDropPath;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate; 
  double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate, 
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      id: json['id']as int,
      title: json['title']as String,
      backDropPath: json['backdrop_path'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
      voteAverage: json['vote_average'] as double,
    );
  }
}
