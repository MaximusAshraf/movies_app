import 'package:flutter/material.dart';
import 'package:movies_app/views/style/app_style.dart';
class AppButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final OutlinedBorder? shape;
  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.color,
    this.text,
    this.onPressed,
    this.shape
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Color? textColor = color == null ? null :
    (color?.computeLuminance() ?? 0.0) > 0.4
        ? Colors.black : Colors.white;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color, padding: EdgeInsets.all(
            14 * AppStyle.scaleFactor(context),
          ),
          shape: shape ?? const BeveledRectangleBorder(),
        ),
        onPressed: onPressed,
        child: Text(
          text ?? "",
        )
    );
  }
}
