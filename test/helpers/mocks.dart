import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/controllers/api/movies_api.dart';
import 'package:movies_app/controllers/data/movies_controller.dart';
import 'package:movies_app/controllers/managers/http_service.dart';
import 'package:movies_app/controllers/managers/request_status_controller.dart';
import 'package:movies_app/models/movies/movie.dart';
import 'package:movies_app/providers/generic_providers/filtered_pagination_provider.dart';

class MockMoviesApi extends Mock implements MoviesApi {}

class MockMoviesController extends Mock implements MoviesController {}

class MockHttpService extends Mock implements HttpService {}

class MockHttpClint extends Mock implements Client {}

class MockRequestStatusController extends Mock implements RequestStatusController {}

class MockMovie extends Mock implements Movie {}

class MockPaginationFilteredProvider extends Mock implements PaginationFilteredProvider {}

