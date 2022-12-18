import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/models/movies/movie_filters.dart';
import 'package:movies_app/providers/generic_providers/filtered_pagination_provider.dart';

class DiscoveredMoviesProvider extends PaginationFilteredProvider<Movie,MovieFilters>{
  DiscoveredMoviesProvider(super.api, super.mapper);
}