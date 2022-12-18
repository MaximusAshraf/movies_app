import 'package:flutter/material.dart';
import 'package:movies_app/controllers/managers/app_messages_controller.dart';
import 'package:movies_app/controllers/managers/request_status_controller.dart';
import 'package:movies_app/enums/request_status.dart';
import 'package:movies_app/providers/movies/discover_movies_provider.dart';
import 'package:movies_app/views/widgets/loaders/lazy_loading.dart';
import 'package:movies_app/views/widgets/loaders/loading_manager.dart';
import 'package:movies_app/views/widgets/movies/movies_list.dart';
import 'package:provider/provider.dart';
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final discoverProvider = Provider.of<DiscoveredMoviesProvider>(context);
    return LoadingManager(
      onRefresh: () async {
        final status = await discoverProvider.getData(reset: true);
        if(status != RequestStatus.success){
          AppMessages.show(RequestStatusController.getStatusMessage(status: status));
        }
      },
      status: discoverProvider.response.status,
      child: LazyLoading(
        nextPage: discoverProvider.response.data?.next,
        onLazyLoad: () async {
          final status = await discoverProvider.getData();
          if(status != RequestStatus.success){
            AppMessages.show(RequestStatusController.getStatusMessage(status: status));
          }
        },
        child: MoviesList(
          items: discoverProvider.response.data?.list,
          onPressed: (movie){
            // open details page if needed
          },
        ),
      ),
    );
  }
}
