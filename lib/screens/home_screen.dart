import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/movie_providers.dart';
import 'package:movie_app/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MovieProvider>(context, listen: false);

    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBarWidget(
          screenTitle: 'Letterboxd',
          isHomeScreen: true,
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
            } else if(snapshot.hasError) {
              return const Center( child: Text('Error Loading Movies!') );
            }

            List<Movie> movies = movieProvider.movies;

            return Consumer<MovieProvider>(
              builder: (context, movieProvider, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: movieProvider.backgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 15),
                        child: Text(
                          'Top picks',
                          style: TextStyle(
                            color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: movies.length,
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
                                          image: AssetImage('assets/images/${movies[index].moviePoster}'),
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
                                        movies[index].movieName,
                                        style: TextStyle(
                                          color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        movies[index].movieReleaseDate,
                                        style: TextStyle(color: movieProvider.isDarkMode ? Colors.white70 : Colors.black87),
                                     ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      var movie = movies[index];

                                      if(!movieProvider.movieList.any( (m) => m['movie_name'] == movie.movieName)) {
                                        movieProvider.addToList(movie);
                                      } else {
                                        movieProvider.removeFromList(movie);
                                      }
                                    },
                                    child: Icon(
                                      Icons.watch_later,
                                      color: movieProvider.movieList.any( (m) => m['movie_name'] == movies[index].movieName)
                                        ? Colors.green
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
            );
          },
        ),
      ),
    );
  }
}