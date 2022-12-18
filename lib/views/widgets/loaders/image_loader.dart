import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/views/style/app_style.dart';

class ImageLoader extends StatelessWidget {
  final String? url;
  final BoxFit ?boxFit;
  final Color ?color;
  final Color? errorColor;
  final Alignment ?alignment;
  final Widget ?errorWidget;
  final double failedIconSize;
  const ImageLoader({
    Key ?key,
    required this.url ,
    this.boxFit,
    this.color,
    this.alignment,
    this.errorWidget,
    this.failedIconSize = 32,
    this.errorColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(url?.isEmpty != false){
      return Center(
          child: Icon(Icons.broken_image_rounded,
            color: errorColor,
            size: failedIconSize * AppStyle.scaleFactor(context),
          )
      );
    }
    Widget image;
    Size size = MediaQuery.of(context).size;
    int height = (size.height * 1.5).toInt();
    int width = (size.width * 1.5).toInt();
    image = CachedNetworkImage(
      imageUrl: url ?? "",
      fit: boxFit ?? BoxFit.cover,
      alignment: Alignment.center,
      memCacheHeight: height,
      memCacheWidth: width,
      maxWidthDiskCache: width,
      maxHeightDiskCache: height,
      placeholder: (context, url) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error){
        return errorWidget ?? Center(
          child: Icon(Icons.broken_image_rounded,
            color: errorColor,
            size: failedIconSize * AppStyle.scaleFactor(context),
          )
        );
      },
    );
    if(color == null) {
      return image;
    }
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
      child: image,
    );
  }
}
