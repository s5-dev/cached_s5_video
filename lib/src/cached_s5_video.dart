import 'dart:typed_data';

import 'package:cached_s5_manager/cached_s5_manager.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:s5/s5.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class CachedS5Video extends StatefulWidget {
  final String cid;
  final S5 s5;
  final CachedS5Manager? cacheManager;
  const CachedS5Video({
    super.key,
    required this.cid,
    required this.s5,
    this.cacheManager,
  });

  @override
  State<CachedS5Video> createState() => CachedS5VideoState();
}

class CachedS5VideoState extends State<CachedS5Video> {
  late CachedS5Manager cacheManager;
  final Logger logger = Logger();
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    cacheManager = widget.cacheManager ?? CachedS5Manager(s5: widget.s5);
    _populateVideoFromCID();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  _populateVideoFromCID() async {
    Uint8List vidBytes = await cacheManager.getBytesFromCID(widget.cid);
    await player.open(await Media.memory(vidBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        child: Video(controller: controller),
      ),
    );
  }
}
