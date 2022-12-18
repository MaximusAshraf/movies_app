

import 'package:movies_app/controllers/constants/urls.dart';

class Movie{

  String name;
  String? thumbnail;
  String overview ;
  DateTime? releaseDate;

  Movie({
    required this.name,
    required this.thumbnail,
    required this.overview,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String,dynamic> parsedJson){
    return Movie(
      name: parsedJson["title"] ?? "???",
      thumbnail: Urls.moviesImagesBaseUrl + (parsedJson["poster_path"] ?? ""),
      overview: parsedJson["overview"] ?? "???",
      releaseDate: DateTime.tryParse(parsedJson["release_date"] ?? ""),
    );
  }
}