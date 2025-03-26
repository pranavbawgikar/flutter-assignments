import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> movies = [];
  bool isDarkMode = false;

  Color get backgroundColor => isDarkMode ? Colors.black87 : Colors.white;

  List<Map<String, dynamic>> watchList = [];

  void switchDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  List<Map<String, dynamic>> movieList = [
    {
      "movie_name": "The Fundamentals of Caring",
      "movie_release_date": "June 16, 2016",
      "movie_language": "English",
      "actors": ["Paul Rudd", "Craig Roberts", "Selena Gomez"],
      "imdb_rating": 7.3,
      "movie_poster": "the-fundamentals-of-caring.jpg"
    },
    {
      "movie_name": "Takedown",
      "movie_release_date": "March 15, 2000",
      "movie_language": "English",
      "actors": ["Skeet Ulrich", "Russell Wong", "Angela Featherstone"],
      "imdb_rating": 6.1,
      "movie_poster": "takedown.jpg"
    },
    {
      "movie_name": "Flowers and Trees",
      "movie_release_date": "July 30, 1932",
      "movie_language": "English",
      "actors": ["N/A"],
      "imdb_rating": 6.8,
      "movie_poster": "flowers-and-trees.jpg"
    },
    {
      "movie_name": "The Unforgivable",
      "movie_release_date": "November 24, 2021",
      "movie_language": "English",
      "actors": ["Sandra Bullock", "Viola Davis", "Vincent D'Onofrio"],
      "imdb_rating": 7.4,
      "movie_poster": "the-unforgivable.jpg"
    },
    {
      "movie_name": "Hellboy Animated: Blood and Iron",
      "movie_release_date": "March 10, 2007",
      "movie_language": "English",
      "actors": ["Ron Perlman", "Selma Blair", "John Hurt"],
      "imdb_rating": 6.3,
      "movie_poster": "hellboy.jpg"
    },
    {
      "movie_name": "The Collector",
      "movie_release_date": "July 09, 2009",
      "movie_language": "English",
      "actors": ["Josh Stewart", "Andrea Roth", "Juan Fernández"],
      "imdb_rating": 6.4,
      "movie_poster": "the-collector.jpg"
    },
    {
      "movie_name": "Transformers",
      "movie_release_date": "July 03, 2007",
      "movie_language": "English",
      "actors": ["Shia LaBeouf", "Megan Fox", "Josh Duhamel"],
      "imdb_rating": 7.0,
      "movie_poster": "transformers.jpg"
    },
    {
      "movie_name": "1917",
      "movie_release_date": "December 25, 2019",
      "movie_language": "English",
      "actors": ["George MacKay", "Dean-Charles Chapman", "Mark Strong"],
      "imdb_rating": 8.3,
      "movie_poster": "1917.jpeg"
    },
    {
      "movie_name": "Aftersun",
      "movie_release_date": "May 21, 2022",
      "movie_language": "English",
      "actors": ["Paul Mescal", "Frankie Corio", "Celia Rowlson-Hall"],
      "imdb_rating": 7.7,
      "movie_poster": "aftersun.jpg"
    },
    {
      "movie_name": "American Psycho",
      "movie_release_date": "April 14, 2000",
      "movie_language": "English",
      "actors": ["Christian Bale", "Justin Theroux", "Josh Lucas"],
      "imdb_rating": 7.6,
      "movie_poster": "american-psycho.jpg"
    },
    {
      "movie_name": "Jaws",
      "movie_release_date": "June 20, 1975",
      "movie_language": "English",
      "actors": ["Roy Scheider", "Robert Shaw", "Richard Dreyfuss"],
      "imdb_rating": 8.1,
      "movie_poster": "jaws.jpg"
    },
    {
      "movie_name": "Athena",
      "movie_release_date": "September 23, 2022",
      "movie_language": "French",
      "actors": ["Dali Benssalah", "Sami Slimane", "Anthony Bajon"],
      "imdb_rating": 6.8,
      "movie_poster": "athena.jpg"
    }
  ];

  void addToList(Movie movie) {
    if(!watchList.contains(movie)) {
      watchList.add({
        'movie_name': movie.movieName,
        'movie_release_date': movie.movieReleaseDate,
        'movie_language': movie.movieLanguage,
        'actors': movie.actors,
        'imdb_rating': movie.imdbRating,
        'movie_poster': movie.moviePoster,
      });
    }
    notifyListeners();
  }

  void removeFromList(Movie movie) {
    watchList.removeWhere( (item) => item['movie_name'] == movie.movieName);
    notifyListeners();
  }

  Future<List<Movie>> fetchMovies() async {
    await Future.delayed(const Duration(seconds: 2));

    movies = movieList.map( (temp) {
      return Movie(
        actors: List<String>.from(temp['actors']),
        imdbRating: temp['imdb_rating'].toDouble(),
        movieLanguage: temp['movie_language'],
        movieName: temp['movie_name'],
        movieReleaseDate: temp['movie_release_date'],
        moviePoster: temp['movie_poster'],
      );
    }).toList();

    return movies;
  }
}
