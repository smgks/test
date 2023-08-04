
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:temp/feature/image_search/ui/bloc/image_search_bloc.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    ImageSearchBloc bloc = context.read<ImageSearchBloc>();
    return SliverAppBar(
      floating: true,
      collapsedHeight: 84,
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      flexibleSpace: SafeArea(
        child: TextField(
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
          decoration: InputDecoration(
            hintText: 'Search',
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(64),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            prefixIcon: const FittedBox(
              child: Icon(
                CupertinoIcons.search,
              ),
            ).paddingDirectional(vertical: 10, start: 16, end: 10),
          ),
          onChanged: (value) {
            bloc.add(ChangeSearchQueryEvent(value));
          },
        ).paddingDirectional(top: 20,horizontal: 24),
      ),
    );
  }
}