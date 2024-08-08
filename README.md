# cached_s5_video

A simple cached video provider for S5 CID's

![Demo GIF](https://github.com/s5-dev/cached_s5_video/blob/main/static/demo.gif?raw=true)

### Usage

> ⚠️ Due to the current state of the S5 dart library, the entire video is cached to memory. So DO NOT use large video files with the library until this is addressed.

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
