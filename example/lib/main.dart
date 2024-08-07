import 'package:cached_s5_manager/cached_s5_manager.dart';
import 'package:cached_s5_video/cached_s5_video.dart';
import 'package:cached_s5_video_example/src/s5.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:media_kit/media_kit.dart';
import 'package:s5/s5.dart';

void main() {
  // IMPORTANT: Don't forget to copy these lines
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  runApp(const CachedS5ImageDemo());
}

class CachedS5ImageDemo extends StatelessWidget {
  const CachedS5ImageDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cached S5 Image Demo',
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String? cid;
  final TextEditingController _cidController = TextEditingController(
      text: "z2H7M3Jipku7Qnt9dpAvFcsHskGewLZqAn9LiSXCVFEqy6aKcTTP");
  S5? s5;
  Logger logger = Logger();
  CachedS5Manager? cacheManager;
  @override
  void initState() {
    _initS5();
    _initCache();
    super.initState();
  }

  void _initCache() async {
    cacheManager?.init();
  }

  void _initS5() async {
    // this is an EXAMPLE s5 node, use your own for maximum performance
    s5 = await initS5("https://s5.ninja", "hive", null);
    cacheManager = CachedS5Manager(s5: s5!);
    setState(() {}); // to update UI
  }

  void _submitCID() async {
    if (s5 != null) {
      setState(() {
        cid = _cidController.text;
      });
    }
  }

  void _clearCache() async {
    cacheManager?.clear();
  }

  void _clearImage() async {
    setState(() {
      cid = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              const Text("S5 Status:"),
              (s5 == null)
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.check),
            ],
          ),
          TextField(
            controller: _cidController,
            decoration: const InputDecoration(labelText: "CID: z2..."),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _submitCID, child: const Text("Submit CID")),
              ElevatedButton(
                  onPressed: _clearCache, child: const Text("Clear Cache")),
              ElevatedButton(
                  onPressed: _clearImage,
                  child: const Text("Clear loaded image"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: (cid != null && s5 != null)
                ? CachedS5Video(
                    cid: cid!,
                    s5: s5!,
                    cacheManager: cacheManager,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
