import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: AspectRatio(
          aspectRatio: 1,
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFF1b1817),
          ),
        ),
      ),
    );
  }
}