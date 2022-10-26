import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:test/test.dart';

void main() {
  test('test both image and asset', () {
    SanityImage image = SanityImage.fromJson({
      'image': {
        'asset': {'_ref': 'myRef'},
      },
      'asset': {
        '_id': 'myId',
      }
    });
  });

  test('test both image and asset 1', () {
    SanityImage image = SanityImage.fromJson({
      'image': {
        '_type': 'image',
        'asset': {
          '_ref':
              'image-fd110b36d8136c66f4dd950be748c7486871182d-3913x4891-jpg',
          '_type': 'reference'
        }
      },
      'asset': {
        '_id': 'myId',
      }
    });
  });

  test('test both image and asset 2', () {
    SanityImage image = SanityImage.fromJson({
      'image': {
        '_type': 'image',
        'asset': {
          '_ref':
              'image-fd110b36d8136c66f4dd950be748c7486871182d-3913x4891-jpg',
          '_type': 'reference'
        },
        'crop': {
          '_type': 'sanity.imageCrop',
          'bottom': 0,
          'left': 0,
          'right': 0,
          'top': 0
        },
        'hotspot': {
          '_type': 'sanity.imageHotspot',
          'height': 1,
          'width': 1,
          'x': 0.5,
          'y': 0.5
        }
      },
      'asset': {
        '_id': 'myId',
      }
    });
  });
}
