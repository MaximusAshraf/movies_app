import 'package:flutter/material.dart';
import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/views/style/app_style.dart';
import 'package:movies_app/views/widgets/loaders/no_item_found.dart';
import 'package:movies_app/views/widgets/movies/movie_item.dart';

/// display list of Movies
class MoviesList extends StatelessWidget {
  /// Movies items
  final List<Movie>? items;
  /// action on item Pressed
  final Function(Movie)? onPressed;
  const MoviesList({Key? key, required this.items, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(items?.isEmpty != false){
      return const NoItemFound();
    }
    return ListView.builder(
      padding: EdgeInsets.all(16 *AppStyle.scaleFactor(context)),
      itemCount: items?.length,
      itemBuilder: (context,index){
        final item = items![index];
        return MovieItem(
          movie: item,
          onPressed: onPressed,
        );
      }
    );
  }
}
