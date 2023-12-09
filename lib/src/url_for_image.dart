import 'dart:math';

import 'package:flutter_sanity_image_url/src/model/crop.dart';
import 'package:flutter_sanity_image_url/src/model/reference_data.dart';
import 'model/sanity_image.dart';

String urlForImage(
    dynamic client, SanityImageSource image, Map<String, dynamic> options) {
  ReferenceData asset = image.parseAssetId();

  // do we have hotspot and crop information.
  if (image is SanityImage) {
    // Compute crop rect in terms of pixel coordinates in the raw source image
    LTWH crop = image.crop.toImageCoordinates(asset);

    // Compute hot spot rect in terms of pixel coordinates
    Crop hotspot = image.hotspot.toImageCoordinates(asset);

    // If irrelevant, or if we are requested to: don't perform crop/fit based on
    // the crop/hotspot.
    if (!(options['rect'] != null ||
        options['focalPoint'] != null ||
        options['ignoreImageParams'] == true ||
        options['crop'] != null)) {
      options.addAll(fit(crop, hotspot, options));
    }
    options.remove('ignoreImageParams');
  }

  return specToImageUrl(client, asset, options);
}

String specToImageUrl(
    client, ReferenceData asset, Map<String, dynamic> options) {
  const cdnUrl = 'https://cdn.sanity.io';
  final baseUrl =
      '$cdnUrl/images/${client.projectId}/${client.dataset}/${asset.filename}';

  List urlParams = [];

  if (options.containsKey('flip_v') || options.containsKey('flip_h')) {
    String flipV = options['flip_v'] != null ? 'v' : '';
    String flipH = options['flip_h'] != null ? 'h' : '';
    urlParams.add('flip=$flipH$flipV');
    options.remove('flip_v');
    options.remove('flip_h');
  }

  if (options.containsKey('rect')) {
    var rect = options['rect'];

    bool isEffectiveCrop = rect[0] != 0 ||
        rect[1] != 0 ||
        rect[2] != asset.height ||
        rect[3] != asset.width;

    if (isEffectiveCrop) {
      urlParams.add('rect=${rect.join(',')}');
    }
    options.remove('rect');
  }

  options.forEach((key, value) {
    if (value == null) {
      return;
    }

    return urlParams.add('$key=$value');
  });

  if (urlParams.length == 0) {
    return baseUrl;
  }

  return "$baseUrl?${urlParams.join('&')}";
}

Map<String, dynamic> fit(LTWH crop, Crop hotspot, Map<String, dynamic> spec) {
  final int? imgWidth = spec['w'];
  final int? imgHeight = spec['h'];

  if (imgWidth == null || imgHeight == null) {
    List<num> rectList = [crop.left, crop.top, crop.width, crop.height];
    return {'w': imgWidth, 'h': imgHeight, 'rect': rectList};
  }

  final aspectRatio = imgWidth / imgHeight;
  final cropAspectRatio = crop.width / crop.height;

  List<int> cropRect;

  if (cropAspectRatio > aspectRatio) {
    final height = crop.height.round();
    final width = (height * aspectRatio).round();
    final top = max(0, crop.top.round());

    // Center output horizontally over hotspot
    final hotspotXCenter =
        ((hotspot.right - hotspot.left) / 2 + hotspot.left).round();
    var left = max(0, (hotspotXCenter - width / 2).round());

    // Keep output within crop
    if (left < crop.left) {
      left = crop.left;
    } else if (left + width > crop.left + crop.width) {
      left = crop.left + crop.width - width;
    }

    cropRect = [left, top, width, height];
  } else {
    // The crop is taller than the desired ratio, we are cutting from top and bottom
    final width = crop.width;
    final height = (width / aspectRatio).round();
    final left = max(0, crop.left.round());

    // Center output vertically over hotspot
    final hotspotYCenter =
        ((hotspot.bottom - hotspot.top) / 2 + hotspot.top).round();
    var top = max(0, (hotspotYCenter - height / 2).round());

    // Keep output rect within crop
    if (top < crop.top) {
      top = crop.top;
    } else if (top + height > crop.top + crop.height) {
      top = crop.top + crop.height - height;
    }

    cropRect = [left, top, width, height];
  }

  return {
    'w': imgWidth,
    'h': imgHeight,
    'rect': cropRect,
  };
}
