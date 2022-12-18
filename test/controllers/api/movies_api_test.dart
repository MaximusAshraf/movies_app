import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/controllers/api/movies_api.dart';
import 'package:movies_app/controllers/constants/urls.dart';
import 'package:movies_app/enums/request_status.dart';
import 'package:movies_app/models/app_response.dart';
import 'package:movies_app/models/movies/movie_filters.dart';

import '../../helpers/mocks.dart';
import '../../helpers/samples.dart';

void main() {
  group('Movies Api', () {
    test('getDiscoverMovies', () async {
      final service = MockHttpService();

      when(() => service.get("${Urls.discoverMovies}&page=1"))
          .thenAnswer((_) async =>
          AppResponse<String>(
            data: discoverJson,
            status: RequestStatus.success,
          ));

      final result = await MoviesApi.instance.getDiscoverMovies(page: 1, filters: null,service: service);
      expect(result.status, RequestStatus.success);
      expect(result.data, isA<Map<String,dynamic>>());
      expect(result.data["page"], 1);
      expect(result.data["results"], isA<List>());
      expect(result.data["total_pages"], 36347);
      expect(result.data["total_results"], 726940);
    });

    test('getSearchMovies', () async {
      final service = MockHttpService();

      when(() => service.get("${Urls.searchMovies}&page=1"))
          .thenAnswer((_) async =>
          AppResponse<String>(
            data: searchJson,
            status: RequestStatus.success,
          ));

      final result = await MoviesApi.instance.getSearchMovies(page: 1, filters: MovieFilters(name: "max"));
      expect(result.status, RequestStatus.success);
      expect(result.data, isA<Map<String,dynamic>>());
      expect(result.data["page"], 1);
      expect(result.data["results"], isA<List>());
      expect(result.data["results"].length, 20);
      expect(result.data["total_pages"], 49);
      expect(result.data["total_results"], 966);
    });
  });
}