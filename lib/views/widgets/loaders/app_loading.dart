import 'package:flutter/material.dart';
import 'package:movies_app/views/style/app_style.dart';
class AppLoading extends StatelessWidget {

  final Color? color;

  const AppLoading({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.0 * AppStyle.scaleFactor(context)),
        child: CircularProgressIndicator(color: color,),
      ),
    );
  }
}
