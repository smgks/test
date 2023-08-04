import 'package:flutter/material.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF0A0401),
      surfaceTint: Color(0xFF1a1716),
      primary: Color(0xFFEDE939),
    ),
  );
}