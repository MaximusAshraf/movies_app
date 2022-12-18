import 'package:flutter/material.dart';
import 'package:movies_app/views/screens/discover_screen.dart';
import 'package:movies_app/views/screens/search_screen.dart';

/// Screen to switch between [SearchScreen] and [DiscoverScreen]
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(tabs: [
            Tab(text: "Discover",icon: Icon(Icons.movie_filter),),
            Tab(text: "Search",icon: Icon(Icons.search),),
          ]),
        ),
        body: const TabBarView(
          children: [
            DiscoverScreen(),
            SearchScreen(),
          ],
        ),
      ),
    );
  }
}
