import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/models/movies/movie.dart';

import '../helpers/samples.dart';

void main() {
  group('Movie test', () {
    test('Movie.fromJson', (){
      expect(Movie.fromJson(movieMap).name, movieObject.name);
      expect(Movie.fromJson(movieMap).releaseDate, movieObject.releaseDate);
      expect(Movie.fromJson(movieMap).overview, movieObject.overview);
      expect(Movie.fromJson(movieMap).thumbnail, movieObject.thumbnail);
    });
  });
}