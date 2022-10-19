import 'dart:math';

import 'package:flutter_sanity_image_url/parseAssetId.dart';

String urlForImage(
    dynamic client, Map<String, dynamic> image, Map<String, dynamic> options) {
  final asset = parseAssetId(image['asset']['_ref']);

  // Compute crop rect in terms of pixel coordinates in the raw source image
  final cropLeft = (image['crop']['left'] * asset['width']).round();
  final cropTop = (image['crop']['top'] * asset['height']).round();
  final Map<String, int> crop = {
    'left': cropLeft,
    'top': cropTop,
    'width':
        (asset['width'] - image['crop']['right'] * asset['width'] - cropLeft)
            .round(),
    'height':
        (asset['height'] - image['crop']['bottom'] * asset['height'] - cropTop)
            .round(),
  };

  // Compute hot spot rect in terms of pixel coordinates
  final hotSpotVerticalRadius =
      (image['hotspot']['height'] * asset['height']) / 2;
  final hotSpotHorizontalRadius =
      (image['hotspot']['width'] * asset['width']) / 2;
  final hotSpotCenterX = image['hotspot']['x'] * asset['width'];
  final hotSpotCenterY = image['hotspot']['y'] * asset['height'];
  final hotspot = {
    'left': hotSpotCenterX - hotSpotHorizontalRadius,
    'top': hotSpotCenterY - hotSpotVerticalRadius,
    'right': hotSpotCenterX + hotSpotHorizontalRadius,
    'bottom': hotSpotCenterY + hotSpotVerticalRadius,
  };

  // If irrelevant, or if we are requested to: don't perform crop/fit based on
  // the crop/hotspot.
  if (!(options['rect'] != null ||
      options['focalPoint'] != null ||
      options['ignoreImageParams'] != null ||
      options['crop'] != null)) {
    options.addAll(fit(crop, hotspot, options));
  }

  return specToImageUrl(client, asset, options);
}

String specToImageUrl(client, asset, Map<String, dynamic> options) {
  const cdnUrl = 'https://cdn.sanity.io';
  final filename =
      '${asset['id']}-${asset['width']}x${asset['height']}.${asset['format']}';
  final baseUrl =
      '$cdnUrl/images/${client.projectId}/${client.dataset}/$filename';

  List urlParams = [];

  if (options.containsKey('flip_v') || options.containsKey('flip_h')) {
    String flip_v = options['flip_v'] != null ? 'v' : '';
    String flip_h = options['flip_h'] != null ? 'h' : '';
    urlParams.add('flip=$flip_v$flip_h');
  }

  if (options.containsKey('rect')) {
    urlParams.add('rect=${options['rect'].join(',')}');
  }

  options.forEach((key, value) {
    if (value == null) {
      return;
    }

    return urlParams.add('$key=$value');
  });

  // print("$baseUrl}?${urlParams.join('&')}");
  return "$baseUrl?${urlParams.join('&')}";
}

Map<String, dynamic> fit(Map<String, dynamic> crop,
    Map<String, dynamic> hotspot, Map<String, dynamic> spec) {
  final int? imgWidth = spec['w'];
  final int? imgHeight = spec['h'];

  if (imgWidth == null || imgHeight == null) {
    List<num> rectList = [
      crop['left'],
      crop['top'],
      crop['width'],
      crop['height']
    ];
    return {'w': imgWidth, 'h': imgHeight, 'rect': rectList};
  }

  final aspectRatio = imgWidth / imgHeight;
  final cropAspectRatio = crop['width']! / crop['height']!;

  List<int> cropRect;

  if (cropAspectRatio > aspectRatio) {
    final height = crop['height']!.round();
    final width = (height * aspectRatio).round();
    final top = max(0, crop['top']!.round() as int);

    // Center output horizontally over hotspot
    final hotspotXCenter =
        ((hotspot['right']! - hotspot['left']!) / 2 + hotspot['left']!).round();
    var left = max(0, (hotspotXCenter - width / 2).round() as int);

    // Keep output within crop
    if (left < crop['left']!) {
      left = crop['left']!;
    } else if (left + width > crop['left']! + crop['width']!) {
      left = crop['left']! + crop['width']! - width;
    }

    cropRect = [left, top, width, height];
  } else {
    // The crop is taller than the desired ratio, we are cutting from top and bottom
    final width = crop['width']!;
    final height = (width / aspectRatio).round();
    final left = max(0, crop['left']!.round() as int);

    // Center output vertically over hotspot
    final hotspotYCenter =
        ((hotspot['bottom']! - hotspot['top']!) / 2 + hotspot['top']!).round();
    var top = max(0, (hotspotYCenter - height / 2).round() as int);

    // Keep output rect within crop
    if (top < crop['top']!) {
      top = crop['top']!;
    } else if (top + height > crop['top']! + crop['height']!) {
      top = crop['top']! + crop['height']! - height;
    }

    cropRect = [left, top, width, height];
  }

  return {
    'w': imgWidth,
    'h': imgHeight,
    'rect': cropRect,
  };
}
