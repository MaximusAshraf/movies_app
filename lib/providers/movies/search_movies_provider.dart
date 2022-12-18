import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/models/movies/movie_filters.dart';
import 'package:movies_app/providers/generic_providers/filtered_pagination_provider.dart';

class SearchMoviesProvider extends PaginationFilteredProvider<Movie,MovieFilters>{
  SearchMoviesProvider(super.api, super.mapper);
}