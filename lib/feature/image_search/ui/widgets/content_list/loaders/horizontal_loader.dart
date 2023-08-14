import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import 'loader.dart';
import '/feature/image_search/ui/bloc/image_search_bloc.dart';

class HorizontalLoader extends StatelessWidget {
  const HorizontalLoader({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ImageSearchBloc>().add(
      LoadNextPageEvent(),
    );
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      margin: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 256,
        ),
        child: const AspectRatio(
          aspectRatio: ((156*2)+18)/200,
          child: Loader(),
        ),
      ).clipRRect(all: 14).paddingDirectional(vertical: 10),
    );
  }
}