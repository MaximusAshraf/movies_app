
import 'package:flutter/material.dart';
import 'package:movies_app/views/style/app_style.dart';
import 'package:movies_app/views/widgets/buttons/app_button.dart';

class NoItemFound extends StatelessWidget {
  final String ?message;
  final String ?buttonText;
  final bool stropRefresh;
  final VoidCallback ?onAddItem;
  const NoItemFound({
    Key ?key,
    this.message,
    this.buttonText,
    this.onAddItem,
    this.stropRefresh = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size =  MediaQuery.of(context).size.width/ 1.5;
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8 * AppStyle.scaleFactor(context),),
              Icon(Icons.search,size: 54 * AppStyle.scaleFactor(context),
                color: Theme.of(context).colorScheme.primary,),
              SizedBox(height: 24 * AppStyle.scaleFactor(context),),
              Text(
                message ?? "No item found",
                style: Theme.of(context).textTheme.caption?.copyWith(
                  fontSize: 14,
                ),
              ),
              onAddItem == null ? const SizedBox.shrink() :
              Column(
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    width: size,
                    child: AppButton(
                      text: buttonText ?? "",
                      onPressed: onAddItem,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if(!stropRefresh) ListView(),
      ],
    );
  }
}
