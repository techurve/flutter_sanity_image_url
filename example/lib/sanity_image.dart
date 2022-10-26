import 'package:flutter_sanity_image_url/flutter_sanity_image_url.dart';

import 'main.dart';

final builder = ImageUrlBuilder(sanityClient);

ImageUrlBuilder urlFor(SanityImageSource asset) {
  return builder.image(asset);
}
