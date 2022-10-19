library flutter_sanity_image_url;

import 'package:flutter_sanity_image_url/src/url_for_image.dart';

class ImageUrlBuilder {
  const ImageUrlBuilder(this.client, {this.asset, Map<String, dynamic>? params})
      : params = params ?? const {};

  final dynamic client;
  final Map<String, dynamic>? asset;
  final Map<String, dynamic> params;

  ImageUrlBuilder copyWith(
      {Map<String, dynamic>? asset, Map<String, dynamic>? params}) {
    return ImageUrlBuilder(this.client,
        asset: asset ?? this.asset, params: params ?? this.params);
  }

  ImageUrlBuilder image(Map<String, dynamic> source) {
    return copyWith(asset: source);
  }

  ImageUrlBuilder width(int pixels) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['w'] = pixels;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder height(int pixels) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['h'] = pixels;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder size(int width, int height) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['h'] = height;
    newParams['w'] = width;
    return copyWith(params: newParams);
  }

  // TODO: does not work
  ImageUrlBuilder focalPoint(int x, int y) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['fp-x'] = x;
    newParams['fp-y'] = y;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder blur(int amount) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['blur'] = amount;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder sharpen(int amount) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['sharp'] = amount;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder invert(bool invert) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['invert'] = invert;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder rect(int left, int top, int width, int height) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['rect'] = [left, top, width, height];
    return copyWith(params: newParams);
  }

  ImageUrlBuilder format(String name) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['fm'] = name;
    return copyWith(params: newParams);
  }

  /// acceptable values 0, 90, 180, 270
  ImageUrlBuilder orientation(int angle) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['or'] = angle;
    return copyWith(params: newParams);
  }

  /// compression quality, where applicable. 0 - 100.
  ImageUrlBuilder quality(int value) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['q'] = value;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder flipHorizontal() {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['flip_h'] = true;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder flipVertical() {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['flip_v'] = true;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder crop(mode) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['crop'] = mode;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder fit(value) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['fit'] = value;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder dpr(value) {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['dpr'] = value;
    return copyWith(params: newParams);
  }

  ImageUrlBuilder ignoreImageParams() {
    Map<String, dynamic> newParams = Map.of(params);
    newParams['ignoreImageParams'] = true;
    return copyWith(params: newParams);
  }

  String url() {
    return urlForImage(client, asset!, params);
  }

  @override
  String toString() {
    return url();
  }
}
