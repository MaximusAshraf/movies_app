class Urls {
  Urls._();

  // host
  static String get _baseUrl => 'https://api.themoviedb.org/3';

  static const _apiKey = "?api_key=95fcdef1dfdf2db736f433378be483aa";
  static const moviesImagesBaseUrl = "https://image.tmdb.org/t/p/w500";

  // routes
  static String get discoverMovies => '$_baseUrl/discover/movie$_apiKey';
  static String get searchMovies => '$_baseUrl/search/movie$_apiKey';
}
