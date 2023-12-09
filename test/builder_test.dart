import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:flutter_sanity_image_url/src/model/crop.dart';
import 'package:flutter_sanity_image_url/src/model/hotspot.dart';
import 'package:test/test.dart';

import 'dummy_client.dart';

void main() {
  group('test url', () {
    late ImageUrlBuilder builder;

    setUp(() {
      builder = ImageUrlBuilder(sanityClient);
    });

    test('throws exception if no image is given.', () {
      expect(() => builder.url(), throwsException);
    });

    test('works with image.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg');
    });

    test('apply rect on image.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .rect(0, 0, 100, 100)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?rect=0,0,100,100');
    });

    test('width 100 on image.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .width(100)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?w=100');
    });

    test('width and height on image.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .width(21)
              .height(10)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?w=21&h=10');
    });

    test('width and height on image, with size method.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .size(21, 10)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?h=10&w=21');
    });

    test('blur image', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .blur(10)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?blur=10');
    });

    test('toString', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .width(21)
              .height(10)
              .toString(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?w=21&h=10');
    });

    test('set image quality.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .quality(21)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?q=21');
    });

    test('sharpen image.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .sharpen(21)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?sharp=21');
    });

    test('invert image.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .invert(true)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?invert=true');
    });

    test('set format.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .format('webp')
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?fm=webp');
    });

    test('set image orientation.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .orientation(90)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?or=90');
    });

    test('flip horizontal.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .flipHorizontal()
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?flip=h');
    });

    test('flip vertical.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .flipVertical()
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?flip=v');
    });

    test('flip both vertical and horizontal.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .flipHorizontal()
              .flipVertical()
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?flip=hv');
    });

    test('change crop type.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .crop('center')
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?crop=center');
    });

    test('flip both vertical and horizontal.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .flipHorizontal()
              .flipVertical()
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?flip=hv');
    });

    test('fit', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .fit(20)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?fit=20');
    });

    test('set dpr.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg'))
              .dpr(10)
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?dpr=10');
    });
  });

  group('crop and hotspot', () {
    late ImageUrlBuilder builder;

    setUp(() {
      builder = ImageUrlBuilder(sanityClient);
    });

    test('apply crop.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg',
                  c: Crop(left: 0.5, top: 0.5, right: 0.5, bottom: 0.5)))
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?rect=600,400,0,0');
    });

    test('crop and hotspot.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg',
                  c: Crop(left: 0.5, top: 0.5, right: 0.5, bottom: 0.5),
                  h: Hotspot(1, 1, 0.5, 0.5)))
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg?rect=600,400,0,0');
    });

    test('ignore image parameters.', () {
      expect(
          builder
              .image(SanityImage(
                  ref:
                      'image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg',
                  c: Crop(left: 0.5, top: 0.5, right: 0.5, bottom: 0.5),
                  h: Hotspot(1, 1, 0.5, 0.5)))
              .ignoreImageParams()
              .url(),
          'https://cdn.sanity.io/images/projectId/production/38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800.jpg');
    });
  });
}
