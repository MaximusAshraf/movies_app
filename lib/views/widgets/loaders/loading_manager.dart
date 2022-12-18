import 'package:flutter/material.dart';
import 'package:movies_app/controllers/managers/request_status_controller.dart';
import 'package:movies_app/enums/request_status.dart';
import 'package:movies_app/views/widgets/loaders/app_loading.dart';
import 'failed_loading_view.dart';
import 'no_item_found.dart';

class LoadingManager extends StatefulWidget {
  final bool hideOnFailure;
  final bool stopRefresh;
  final Color? loaderColor;
  final RequestStatus? status;
  final double ?failedToLoadHeight;
  final Future<void> Function() onRefresh;
  final Widget child;

  const LoadingManager({
    Key ?key,
    required this.onRefresh,
    required this.child,
    required this.status,
    this.stopRefresh = false,
    this.hideOnFailure = false,
    this.failedToLoadHeight,

    this.loaderColor,
  }) : super(key: key);

  @override
  State<LoadingManager> createState() => _LoadingManagerState();
}

class _LoadingManagerState extends State<LoadingManager> {

  @override
  void initState() {
    if(widget.status == null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onRefresh();
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoadingManager oldWidget) {
    if(widget.status == null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onRefresh();
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    Widget ?placeHolder;

    // if loading of still not start in loading (true or null)
    // return loading widget
    if(widget.status == RequestStatus.loading || widget.status == null){
      placeHolder = AppLoading(color: widget.loaderColor,);
    }else if(widget.status != RequestStatus.success){
      // if failed return failed widget
      if(widget.hideOnFailure){
        placeHolder = const SizedBox.shrink();
      } else if(widget.status == RequestStatus.noItemFound){
        // if no item found
        placeHolder = NoItemFound(
          stropRefresh: widget.stopRefresh,
        );
      } else{
        // if failed return failed widget
        placeHolder = Center(
          child: SizedBox(
            height: widget.failedToLoadHeight ?? MediaQuery.of(context).size.width,
            child: FailedLoading(
              stopRefresh: widget.stopRefresh,
              message: RequestStatusController.getStatusMessage(
                  status: widget.status,
              ),
              onReload: () async {
                await widget.onRefresh();
              },
            ),
          ),
        );
      }

    }

    if(widget.stopRefresh) {
      return AnimatedSize(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 400),
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: placeHolder ?? widget.child),
      );
    }

    // if load end successfully return loaded widget
    return RefreshIndicator(
        onRefresh: widget.onRefresh,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: AnimatedSize(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: placeHolder ?? widget.child),
        )
    );
  }
}
