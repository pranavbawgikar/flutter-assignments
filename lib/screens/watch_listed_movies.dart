import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/movie_providers.dart';
import 'package:movie_app/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

class WatchListedMovies extends StatelessWidget {
  const WatchListedMovies({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MovieProvider>(context);
    var watchList = movieProvider.movies;

    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBarWidget(
          screenTitle: 'Letterboxd',
          isHomeScreen: false,
          actionWidget: Switch(
            value: movieProvider.isDarkMode,
            onChanged: (value) {
              movieProvider.switchDarkMode();
            },
            activeColor: Colors.white,
          ),
        ),
        body: FutureBuilder<List<Movie>> (
            future: movieProvider.fetchMovies(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center( child: CircularProgressIndicator() );
              } else if(snapshot.hasError || movieProvider.watchList.isEmpty) {
                return Center(
                  child: Text(
                    'Go ahead, add some movies to your watch list :P',
                    style: TextStyle(
                      color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              List<Movie> watchListedMovies = movieProvider.movies.where( (movie) =>
                  movieProvider.watchList.any((m) => m['movie_name'] == movie.movieName)
              ).toList();

              return Container(
                decoration: BoxDecoration(
                  color: movieProvider.backgroundColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 15),
                      child: Text(
                        'You want to see ${watchListedMovies.length} movies',
                        style: TextStyle(
                          color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: watchListedMovies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 120,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/${watchListedMovies[index].moviePoster}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      watchListedMovies[index].movieName,
                                      style: TextStyle(
                                          color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      watchListedMovies[index].movieReleaseDate,
                                      style: TextStyle(color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    var movie = movieProvider.movies[index];

                                    if(!movieProvider.watchList.any( (m) => m['movie_name'] == movie.movieName)) {
                                      movieProvider.addToList(movie);
                                    } else {
                                      movieProvider.removeFromList(movie);
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: movieProvider.watchList.any( (m) => m['movie_name' == movieProvider.movies[index].movieName] ?? false )
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              );
            }
        ),
      ),
    );
  }
}