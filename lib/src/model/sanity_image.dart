import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';
import 'package:flutter_sanity_image_url/src/model/crop.dart';
import 'package:flutter_sanity_image_url/src/model/hotspot.dart';
import 'package:flutter_sanity_image_url/src/model/reference_data.dart';

const example = 'image-Tb9Ew8CXIwaY6R1kjMvI0uRR-2000x3000-jpg';

/// A model for all types of Sanity Image sources.
abstract class SanityImageSource {
  const SanityImageSource({required this.id});

  final String id;

  get ref {
    return id;
  }

  /// parses the `id` of a reference.
  /// from a [String] id and returns [ReferenceData].
  ReferenceData parseAssetId() {
    final refSplit = id.split('-');

    if (refSplit.length != 4) {
      throw Exception(
          'Malformed asset _ref "$ref". Expected an id like "$example".');
    }

    final dimensions = refSplit[2].split('x');

    final width = int.parse(dimensions[0]);
    final height = int.parse(dimensions[1]);

    return ReferenceData(refSplit[1], width, height, refSplit[3]);
  }
}

/// A model for a Sanity Image.
/// Contains the [SanityAsset], which is the minimum information needed to show an image.
/// Also contains the [Crop] and [Hotspot] which signal how to format the image.
class SanityImage extends SanityImageSource {
  const SanityImage({required String ref, this.c, this.h, this.asset})
      : super(id: ref);

  final SanityAsset? asset;
  final Crop? c;
  final Hotspot? h;

  /// Parses [json] into a [SanityImage].
  /// accepts either a Sanity Image which would look like this:
  /// query would look like: `*[_type=='meditation']{image}`
  /// ```json
  /// "_type": "image",
  /// "asset": {
  ///   "_ref": "image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg",
  ///   "_type": "reference"
  /// }
  /// ```
  /// also accepts a Sanity Image as the expanded asset:
  /// query would look like `*[_type=='meditation']{'image': image.asset->}`
  ///
  /// ```
  /// {
  ///   "_id": "image-38de0164654e709a07ca57d0d7d3ab29ce187dd5-1200x800-jpg",
  ///   "_type": "sanity.imageAsset",
  ///   "metadata": {
  ///     "lqip": ...,
  ///     "palette": {
  ///       ...
  ///     }
  ///   },
  ///   ...
  /// }
  /// ```
  /// the required attributes that should be in the json to be able to display the image are:
  /// + `_ref` if it is a image.
  /// + `_id` if it is an asset.
  /// The third option to make use of both crop and the metadata of the image is to make this query:
  /// `*[_type=='meditation']{'image': {'image': image, 'asset': image.asset->}}`
  /// with this query it is possible to:
  /// + use crop and hotspot
  /// + use lqip
  /// + use the image palette
  static SanityImage fromJson(Map<String, dynamic> json) {
    // an image is passed.
    if (json['asset']?['_ref'] != null) {
      return _fromImageQuery(json);
    }

    // an asset is passed.
    if (json['_id'] != null) {
      return _fromAssetQuery(json);
    }

    // both are passed.
    if (json['image'] != null && json['asset'] != null) {
      return _fromBothQuery(json);
    }

    // nothing matched.
    throw Exception(
        'unable to parse SanityImage from ${json.toString()}, try to change your query.');
  }

  /// parses a [json] with image data.
  /// returns a [SanityImage].
  static SanityImage _fromImageQuery(Map<String, dynamic> json) {
    return SanityImage(
      ref: json['asset']['_ref'],
      c: json['crop'],
      h: json['hotspot'],
    );
  }

  /// parses a [json] with asset data.
  /// returns a [SanityImage].
  static SanityImage _fromAssetQuery(Map<String, dynamic> json) {
    return SanityImage(
      ref: json['_id'],
      asset: SanityAsset.fromJson(json),
    );
  }

  /// parses the combined data from an asset from [json].
  /// returns a [SanityImage].
  static SanityImage _fromBothQuery(Map<String, dynamic> json) {
    return SanityImage(
      ref: json['image']['asset']['_ref'],
      asset: SanityAsset.fromJson(json['asset']),
      c: json['image']?['crop'] == null
          ? null
          : Crop.fromJson(json['image']?['crop']),
      h: json['image']?['hotspot'] == null
          ? null
          : Hotspot.fromJson(json['image']?['hotspot']),
    );
  }

  /// gets the crop of an image.
  Crop get crop {
    return c ?? Crop(left: 0, top: 0, right: 0, bottom: 0);
  }

  /// gets the hotspot of an image.
  Hotspot get hotspot {
    return h ?? Hotspot(1, 1, 0.5, 0.5);
  }

  /// gets the palette of an image.
  SanityPalette? get palette {
    return this.asset?.palette;
  }

  /// gets the low quality image preview of an image.
  String? get lqip {
    return this.asset?.lqip;
  }
}
