const List<Map<String, dynamic>> genres = [
  {"id": 28, "name": "Acción"},
  {"id": 12, "name": "Aventura"},
  {"id": 16, "name": "Animación"},
  {"id": 35, "name": "Comedia"},
  {"id": 80, "name": "Crimen"},
  {"id": 99, "name": "Documental"},
  {"id": 18, "name": "Drama"},
  {"id": 10751, "name": "Familiar"},
  {"id": 14, "name": "Fantasía"},
  {"id": 36, "name": "Historia"},
  {"id": 27, "name": "Terror"},
  {"id": 10402, "name": "Música"},
  {"id": 9648, "name": "Misterio"},
  {"id": 10749, "name": "Romance"},
  {"id": 878, "name": "Ciencia Ficción"},
  {"id": 10770, "name": "Película de TV"},
  {"id": 53, "name": "Suspense"},
  {"id": 10752, "name": "Bélico"},
  {"id": 37, "name": "Western"},
];

List<String> getGenresFromIds(List<int> genreIds) {
  List<String> genresList = [];

  for (int id in genreIds) {
    var genre = genres.firstWhere((element) => element['id'] == id);
      genresList.add(genre['name']);
  }
  return genresList;
}
