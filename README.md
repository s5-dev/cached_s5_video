# cached_s5_video

A simple cached video provider for S5 CID's

![Demo GIF](https://raw.githubusercontent.com/s5-dev/cached_s5_video/main/static/demo.gif)

### Usage

See [example](example/lib/main.dart).

This is a library built on [s5](https://pub.dev/packages/s5). See there for more details.

Basic Usage:

```dart
Widget cachedS5Video = CachedS5Video(
  cid: cid, // String
  s5: s5, // See https://pub.dev/packages/s5
);
```

### Acknowledgement

This work is supported by a [Sia Foundation](https://sia.tech/) grant
