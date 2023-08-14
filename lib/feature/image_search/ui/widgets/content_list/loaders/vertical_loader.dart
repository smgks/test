import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/feature/image_search/ui/bloc/image_search_bloc.dart';
import 'loader.dart';

class VerticalLoader extends StatelessWidget {
  const VerticalLoader({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ImageSearchBloc>().add(
      LoadNextPageEvent(),
    );
    return const Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        margin: EdgeInsets.zero,
        child: Loader(),
      ),
    );
  }
}