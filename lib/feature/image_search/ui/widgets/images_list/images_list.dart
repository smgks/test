import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import '/feature/image_search/ui/bloc/image_search_bloc.dart';
import '/feature/image_search/ui/view_models/image_manager.dart';
import '/feature/image_search/ui/widgets/images_list/horizontal_images.dart';
import '/feature/image_search/ui/widgets/images_list/horizontal_loader.dart';
import '/feature/image_search/ui/widgets/images_list/vertical_image.dart';


class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ImageSearchBloc bloc = context.read<ImageSearchBloc>();
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ImageSearchInitial) {
          return const SliverToBoxAdapter();
        } else if (state is ImageSearchResult) {
          return SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .paddingOf(context)
                  .bottom,
              left: 26,
              top: 0,
              right: 26,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                  ImageManager imageManager = state.imageManager;
                  if (index == imageManager.holders.length) {
                    if (state.error == null) {
                      return const HorizontalLoader();
                    }
                    return Center(
                      child: Text(state.error!),
                    ).padding(all: 20);
                  }
                  if (imageManager.holders[index].isHorizontal) {
                    final ImageHolderHorizontal image =
                    imageManager.holders[index] as ImageHolderHorizontal;
                    return HorizontalImage(image: image);
                  } else {
                    final ImageHolderVertical image =
                    imageManager.holders[index] as ImageHolderVertical;
                    return VerticalImages(image: image);
                  }
                },
                childCount: getChildCount(state),
              )
            ),
          );
        } else if (state is ImageSearchError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.error),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Unexpected error, try again'),
            ),
          );
        }
      },
    );
  }

  int getChildCount(ImageSearchResult state) {
    if (state.isReachedEnd) {
      return state.imageManager.holders.length;
    }
    return state.imageManager.holders.length + (
      state.imageManager.isPageComplete ? 1 : 0
    ) + (
      state.error != null ? 1 : 0
    );
  }
}

