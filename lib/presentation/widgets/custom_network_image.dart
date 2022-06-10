import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String imgUrl;
  final double placeHolderSize;

  const CustomNetworkImage({
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    required this.imgUrl,
    required this.placeHolderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 250),
      fadeOutDuration: const Duration(milliseconds: 250),
      placeholder: (context, url) {
        return Center(
          child: SizedBox(
            width: placeHolderSize,
            height: placeHolderSize,
            child: const SpinKitRing(
              lineWidth: 4,
              color: secondaryColor,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Center(
          child: SizedBox(
            width: placeHolderSize,
            height: placeHolderSize,
            child: const Icon(
              Icons.motion_photos_off_outlined,
              color: secondaryColor,
            ),
          ),
        );
      },
    );
  }
}
