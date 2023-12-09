## 0.0.1

- Add `ImageUrlBuilder` class which can be used to generate sanity urls with options.

## 0.0.2

- Add types:
  - `SanityImage`
  - `SanityAsset`
  - `SanityPalette`
  - `SanityColor`
- Change the builder to use `SanityImageSource` as an asset input, which is either `SanityAsset` or `SanityImage`.
- Add `fromJson` methods for all new model classes, which increases ease of use for sanity features such as `lqip` and the palette.

## 0.0.3

- Various bugfixes.

## 0.1.0

- Add widget `ImagePlaceholder` which can show a Low Quality Image Placeholder while loading an image.
- Add example usages in the `/example` app:
  - example of use of color pallette.
  - example of use of image placeholder.