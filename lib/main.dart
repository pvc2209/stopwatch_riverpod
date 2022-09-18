import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_iap/google_iap.dart';
import 'package:iap_interface/iap_interface.dart';
import 'src/features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
  }
  runApp(ProviderScope(overrides: [
    iapProvider.overrideWithProvider(
      StateNotifierProvider<IapNotifier, IapState>(
        (ref) {
            return IAPGoogleNotifier(ref);
        },
      ),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generate Random',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
