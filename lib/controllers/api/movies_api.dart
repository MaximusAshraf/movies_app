import 'dart:convert';

import 'package:movies_app/controllers/constants/urls.dart';
import 'package:movies_app/controllers/managers/http_service.dart';
import 'package:movies_app/models/app_response.dart';
import 'package:movies_app/models/movies/movie_filters.dart';

/// handle Api calling for movies
class MoviesApi{

  const MoviesApi._();

  static const MoviesApi instance = MoviesApi._();
  /// get movies parsed json for Discover Movies API
  Future<AppResponse> getDiscoverMovies({
    required int page,
    required MovieFilters? filters,
    HttpService service = HttpService.instance
  }) async {
    final response = await service.get(
      "${Urls.discoverMovies}&page=$page",
    );
    return AppResponse(
      status: response.status,
      data: jsonDecode(response.data!)
    );
  }

  /// get movies parsed json for Search Movies API
  Future<AppResponse> getSearchMovies({
    required int page,
    required MovieFilters? filters,
    HttpService service = HttpService.instance
  }) async {
    final response = await service.get(
      "${Urls.searchMovies}&page=$page&query=${filters?.name}",
    );
    return AppResponse(
      status: response.status,
      data: jsonDecode(response.data!)
    );
  }
}