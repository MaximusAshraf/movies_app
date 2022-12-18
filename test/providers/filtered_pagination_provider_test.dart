import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/enums/request_status.dart';
import 'package:movies_app/models/app_response.dart';
import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/models/pagination.dart';
import 'package:movies_app/providers/movies/discover_movies_provider.dart';

import '../helpers/mocks.dart';
import '../helpers/samples.dart';

void main() {
  group('PaginationFilteredProvider', () {
    test('get data success', () async {
      final api = MockMoviesApi();
      final controller = MockMoviesController();

      when(() => api.getDiscoverMovies(page: 1, filters: null))
          .thenAnswer((_) async => AppResponse(
          status: RequestStatus.success,data: moviePaginationMap));

      when(() => controller.mapMovies(moviePaginationMap))
          .thenAnswer((_) => Pagination<Movie>(list: [], next: true,pageIndex: 1,totalPages: 100));

      final provider = DiscoveredMoviesProvider(api.getDiscoverMovies,controller.mapMovies);

      expect(await provider.getData(), RequestStatus.success);
      expect(provider.response.data != null, true);
      expect(provider.response.status,RequestStatus.success);
    });
    test('get data failed', () async {
      final api = MockMoviesApi();
      final controller = MockMoviesController();

      when(() => api.getDiscoverMovies(page: 1, filters: null))
          .thenAnswer((_) async => AppResponse(
          status: RequestStatus.clientError,data: null));

      final provider = DiscoveredMoviesProvider(api.getDiscoverMovies,controller.mapMovies);

      expect(await provider.getData(), RequestStatus.clientError);
      expect(provider.response.data == null, true);
      expect(provider.response.status,RequestStatus.clientError);
    });
  });
}