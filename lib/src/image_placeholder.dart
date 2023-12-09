import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder(
      {super.key, required this.lqip, this.width = 250.0, this.height = 250.0});
  final String? lqip;
  final double width;
  final double height;

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (lqip == null) {
      return Container();
    }
    return Container(
      width: this.width,
      height: this.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageFromBase64String(lqip!).image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
