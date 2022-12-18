
import 'package:flutter/material.dart';

import 'app_loading.dart';
class LazyLoading extends StatefulWidget {
  final Widget child;
  final bool? nextPage;
  final Future<void> Function()? onLazyLoad;

  const LazyLoading({
    Key ?key,
    required this.nextPage,
    required this.child,
    required this.onLazyLoad,
  }) : super(key: key);

  @override
  State<LazyLoading> createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  _scrollListener() async {
    if (!_animationController.isAnimating
        && !_animationController.isCompleted
        && widget.nextPage == true
        && widget.onLazyLoad != null) {
      _animationController.forward();
      setState(() {});
      await widget.onLazyLoad!();
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() {});
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin:  const Offset(0.0, .8),
      end: const Offset(0, .4),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));

  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollEndNotification>(
          onNotification: (notification) {
            if(notification.metrics.pixels >= notification.metrics.maxScrollExtent){
              _scrollListener();
            }
            return false;
          },
          child: widget.child
        ),
        SlideTransition(
          position: _offsetAnimation,
          child: Center(
            child: Visibility(
              visible: _animationController.isAnimating || _animationController.isCompleted,
              child: Container(
                height: 36,
                width: 36,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      offset: Offset(0, 1)
                    )
                  ]
                ),
                child: const AppLoading(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
