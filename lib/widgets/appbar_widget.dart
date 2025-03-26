import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/watch_listed_movies.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  final bool isHomeScreen;
  final Widget? actionWidget;

  AppBarWidget({
    Key? key,
    required this.screenTitle,
    required this.isHomeScreen,
    this.actionWidget,
  }) : super( key: key );

  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            screenTitle,
            style: TextStyle( fontSize: 20, fontWeight: FontWeight.normal ),
          ),
          Spacer(),
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                ),
                child: Text(isHomeScreen ? 'Watch List' : 'Home'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => isHomeScreen ? WatchListedMovies() : HomeScreen(),
                    )
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.teal,
      actions: [
        if(actionWidget != null) actionWidget!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}