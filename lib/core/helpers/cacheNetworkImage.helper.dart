import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HCacheNetworkImage {
  static Container getImage({
    required String url,
    double? height,
    double? width,
    double borderRadius = 0,
    double padding = 0,
    BoxFit boxFit = BoxFit.cover,
    Color color = Colors.transparent,
    Color borderColor = Colors.transparent,
    double borderWidth = 0,
    int? memCacheWidth,
    int? memCacheHeight,
  }) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        placeholder: (context, url) => Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: Border.all(color: borderColor),
            ),
            child: CupertinoActivityIndicator(color: Colors.grey),
          ),
        ),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.image_outlined, color: Colors.grey)),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(image: imageProvider, fit: boxFit),
          ),
        ),
      ),
    );
  }
}
