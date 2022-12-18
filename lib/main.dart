import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies/discover_movies_provider.dart';
import 'package:movies_app/providers/movies/search_movies_provider.dart';
import 'package:movies_app/views/screens/home_screen.dart';
import 'package:movies_app/views/style/app_style.dart';
import 'package:provider/provider.dart';

import 'controllers/api/movies_api.dart';
import 'controllers/data/movies_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DiscoveredMoviesProvider(
            MoviesApi.instance.getDiscoverMovies,MoviesController.instance.mapMovies)),
        ChangeNotifierProvider(create: (_) => SearchMoviesProvider(
            MoviesApi.instance.getSearchMovies,MoviesController.instance.mapMovies)),
      ],
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Movies Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (BuildContext context, Widget? child){
            return MediaQuery(
                data: MediaQuery.maybeOf(context)!.copyWith(
                    textScaleFactor: MediaQuery.maybeOf(context)!.textScaleFactor
                        * AppStyle.scaleFactor(context)
                ),
                child: child!
            );
          },
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
