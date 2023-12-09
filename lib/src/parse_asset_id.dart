const example = 'image-Tb9Ew8CXIwaY6R1kjMvI0uRR-2000x3000-jpg';

/// Parse ref [String] into id, width, height and format attributes.
/// example: 'image-Tb9Ew8CXIwaY6R1kjMvI0uRR-2000x3000-jpg'
/// - id: Tb9Ew8CXIwaY6R1kjMvI0uRR
/// - width: 2000
/// - height: 3000
/// - format: jpg
Map<String, dynamic> parseAssetId(String ref) {
  final refSplit = ref.split('-');

  if (refSplit.length != 4) {
    throw Exception(
        'Malformed asset _ref "$ref". Expected an id like "$example".');
  }

  final dimensions = refSplit[2].split('x');

  final width = int.parse(dimensions[0]);
  final height = int.parse(dimensions[1]);

  return {
    'id': refSplit[1],
    'width': width,
    'height': height,
    'format': refSplit[3]
  };
}
