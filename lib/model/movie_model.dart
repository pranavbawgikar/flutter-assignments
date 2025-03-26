class Movie {
  final String movieName;
  final String movieReleaseDate;
  final String movieLanguage;
  final List<String> actors;
  final double imdbRating;
  final String moviePoster;

  Movie({
    required this.movieName,
    required this.movieReleaseDate,
    required this.movieLanguage,
    required this.actors,
    required this.imdbRating,
    required this.moviePoster,
  });
}