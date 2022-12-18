import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/views/style/app_style.dart';
import 'package:movies_app/views/widgets/loaders/image_loader.dart';
class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(Movie)? onPressed;
  const MovieItem({Key? key, required this.movie, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4 *AppStyle.scaleFactor(context)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed == null ? null : (){
          onPressed!(movie);
        },
        child: SizedBox(
          height: 128 * AppStyle.scaleFactor(context),
          child: Row(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                  child: ImageLoader(url: movie.thumbnail)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movie.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,),
                      if(movie.releaseDate != null)
                      Text(DateFormat.yMMMEd().format(movie.releaseDate!),
                        style: Theme.of(context).textTheme.overline,),
                      Text(movie.overview,
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
