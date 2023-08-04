import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '/feature/image_search/ui/pages/search_page.dart';
import '/di.dart';
import 'core/theme.dart';

void main() {
  configureDependencies('prod');

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getTheme(context),
      home: SearchPage(),
    );
  }
}
