import 'package:flutter/material.dart';
import 'package:movies_app/views/style/app_style.dart';
import 'package:movies_app/views/widgets/buttons/app_button.dart';
class FailedLoading extends StatelessWidget {
  final String? message;
  final bool stopRefresh;
  final VoidCallback ?onReload;

  const FailedLoading({
    Key ?key,
    this.message,
    this.onReload,
    this.stopRefresh = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        stopRefresh ? const SizedBox.shrink() :ListView(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 32 * AppStyle.scaleFactor(context),),
              Icon(Icons.error,size: 54 * AppStyle.scaleFactor(context),
                color: Theme.of(context).colorScheme.error,),
              SizedBox(height: 24 * AppStyle.scaleFactor(context),),
              Text(
                message ?? "Failed to complete request",
                style: Theme.of(context).textTheme.caption?.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 32 * AppStyle.scaleFactor(context),),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: AppButton(
                  text: "Try Again",
                  onPressed: onReload,
                  shape: const StadiumBorder(),
                ),
              ),
              SizedBox(height: 32 * AppStyle.scaleFactor(context),),
            ],
          ),
        ),
      ],
    );
  }
}
