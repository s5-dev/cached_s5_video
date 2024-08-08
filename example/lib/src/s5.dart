import 'package:cached_s5_video_example/src/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:s5/s5.dart';

Future<S5> initS5(String nodeURL, String dbPath, String? inputSeed) async {
  Hive.init(dbPath);
  final S5 s5 =
      await S5.create(logger: (!kIsWeb) ? FileLogger(file: "log.txt") : null);
  if (!s5.hasIdentity) {
    String seed = "";
    if (inputSeed != null && inputSeed.isNotEmpty) {
      seed = inputSeed;
    } else {
      // seed gets saved to hive btw
      seed = s5.generateSeedPhrase();
      print(seed);
    }
    await s5.recoverIdentityFromSeedPhrase(seed);
    await s5.registerOnNewStorageService(
      nodeURL,
    );
  }
  return s5;
}
