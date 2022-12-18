import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/models/pagination.dart';
/// handle mapping events on [Movie] model
class MoviesController{

  const MoviesController._();

  static const MoviesController instance = MoviesController._();

  /// map parsed Json to create [Pagination] of [Movie]
  Pagination<Movie> mapMovies(dynamic parsedJson) {
    parsedJson = parsedJson as Map<String,dynamic>;
    final list = parsedJson["results"] as List;
    final listItems = list.map((e) => Movie.fromJson(e)).toList();
    int page =  parsedJson["page"] ?? 0;
    int totalPages =  parsedJson["total_pages"] ?? 0;
    return Pagination<Movie>(
      list: listItems,
      pageIndex: page,
      totalPages: totalPages,
      next: page < totalPages,
    );
  }
}