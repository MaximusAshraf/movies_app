import 'package:flutter/material.dart';
import 'package:movies_app/controllers/managers/app_messages_controller.dart';
import 'package:movies_app/controllers/managers/request_status_controller.dart';
import 'package:movies_app/enums/request_status.dart';
import 'package:movies_app/models/movies/movie_filters.dart';
import 'package:movies_app/providers/movies/discover_movies_provider.dart';
import 'package:movies_app/providers/movies/search_movies_provider.dart';
import 'package:movies_app/views/style/app_style.dart';
import 'package:movies_app/views/widgets/loaders/lazy_loading.dart';
import 'package:movies_app/views/widgets/loaders/loading_manager.dart';
import 'package:movies_app/views/widgets/loaders/no_item_found.dart';
import 'package:movies_app/views/widgets/movies/movies_list.dart';
import 'package:movies_app/views/widgets/movies/movies_search_bar.dart';
import 'package:provider/provider.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchMoviesProvider>(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0 * AppStyle.scaleFactor(context)),
          child: MoviesSearchBar(
            filters: searchProvider.filters,
            onSearch: (filters){
              searchProvider.filters ??= MovieFilters();
              searchProvider.filters?.fromMovieFilters(filters) ;
              searchProvider.getData(reset: true);
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: searchProvider.filters?.name?.isEmpty != false ?
              const NoItemFound(message: "Search about?",):
          LoadingManager(
            onRefresh: () async {
              final status = await searchProvider.getData(reset: true);
              if(status != RequestStatus.success){
                AppMessages.show(RequestStatusController.getStatusMessage(status: status));
              }
            },
            status: searchProvider.response.status,
            child: LazyLoading(
              nextPage: searchProvider.response.data?.next,
              onLazyLoad: () async {
                final status = await searchProvider.getData();
                if(status != RequestStatus.success){
                  AppMessages.show(RequestStatusController.getStatusMessage(status: status));
                }
              },
              child: MoviesList(
                items: searchProvider.response.data?.list,
                onPressed: (movie){
                  // open details page if needed
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
