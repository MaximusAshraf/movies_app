import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/controllers/data/movies_controller.dart';
import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/models/pagination.dart';

import '../../helpers/samples.dart';

void main() {
  group('Movies Controller', () {
    test('mapMovies', (){

      final result = MoviesController.instance.mapMovies(moviePaginationMap);

      expect(result, isA<Pagination<Movie>>());
      expect(result.next, true);
      expect(result.list.length, 20);
      expect(result.pageIndex, 1);
      expect(result.list, isA<List<Movie>>());
      expect(result.list[1].name, "Mad Max");
      expect(result.totalPages, 49);
    });
  });
}