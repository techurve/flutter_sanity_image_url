library flutter_sanity_image_url;

import 'package:flutter/material.dart';

class ImageUrlBuilder {
  ImageUrlBuilder({ImageUrlBuilderOptions? options})
      : options = options ?? ImageUrlBuilderOptions();

  ImageUrlBuilderOptions options;

  // ImageUrlBuilder copyWith(options) {}

  // image(source) {}

  // ImageUrlBuilder blur(amount) {}

  // ImageUrlBuilder sharpen(amount) {}

  // ImageUrlBuilder invert() {}

  // ImageUrlBuilder rect(left, top, width, height) {}

  // ImageUrlBuilder format(name) {}

  // ImageUrlBuilder auto(mode) {}

  // ImageUrlBuilder orientation(angle) {}

  // ImageUrlBuilder quality(value) {}

  // ImageUrlBuilder forceDownload(defaultFileName) {}

  // flipHorizontal() {}

  // flipVertical() {}

  // crop(mode) {}

  // fit(value) {}

  // dpr(value) {}

  // ignoreImageParams() {}

  // String url() {
  //   return "";
  // }

  @override
  String toString() {
    // return url();
    return "";
  }
}

class ImageUrlBuilderOptions {
  // String baseUrl;
}

class SanityImage extends StatelessWidget {
  SanityImage(this.asset, {this.width, this.height, this.blur});

  Map<String, dynamic> asset;

  int? width;
  int? height;
  int? blur;

  String get assetUrl {
    final params = [];
    String result = asset['url'];

    if (width != null) {
      params.add('h=$width');
    }

    if (height != null) {
      params.add('h=$height');
    }

    if (blur != null) {
      params.add('blur=$blur');
    }

    return '${asset['url']}?${params.join('&')}';
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(assetUrl);
  }
}
