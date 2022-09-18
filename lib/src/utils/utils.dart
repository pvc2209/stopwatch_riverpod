import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> copyFileToLocal(File file) async {
  final appDocDir = await getApplicationSupportDirectory();
  final copiedFile =
      await file.copy('${appDocDir.path}\\${file.path.split('\\').last}');
  return copiedFile;
}

Future<void> clearAllData() async {
  final appDir = await getApplicationSupportDirectory();
  await File(appDir.path).delete(recursive: true);
}
