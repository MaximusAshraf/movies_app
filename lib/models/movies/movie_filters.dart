/// filters used in movies search
class MovieFilters{
  String? name;

  MovieFilters({this.name});

  fromMovieFilters(MovieFilters filters){
    name = filters.name;
  }
}