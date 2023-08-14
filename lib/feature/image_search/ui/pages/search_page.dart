import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/feature/image_search/ui/widgets/content_list/images_list.dart';
import 'package:temp/feature/image_search/ui/widgets/search_bar.dart';

import '/feature/image_search/ui/bloc/image_search_bloc.dart';


class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final ImageSearchBloc bloc = ImageSearchBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocProvider<ImageSearchBloc>.value(
          value: bloc,
          child: const CustomScrollView(
            slivers: [
              SearchAppBar(),
              ImagesList(),
            ],
          ),
        ),
      ),
    );
  }
}

