import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import '/feature/image_search/ui/bloc/image_search_bloc.dart';
import '/feature/image_search/ui/view_models/image_manager.dart';
import 'image_drawers/horizontal_images.dart';
import 'loaders/horizontal_loader.dart';
import 'image_drawers/vertical_image.dart';
import 'package:temp/feature/image_search/domain/entities/media_content.dart';


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
          return buildSearchContent(context, state);
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

  SliverPadding buildSearchContent(
    BuildContext context,
    ImageSearchResult state,
  ) {
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
          ContentManager contentManager = state.imageManager;
          if (index == contentManager.holders.length) {
            return buildExtraSpace(contentManager, state.error);
          }
          return buildContent(contentManager, index);
        },
        childCount: getChildCount(state),
      )),
    );
  }

  StatelessWidget buildContent(
    ContentManager<MediaContentEntity> contentManager,
    int index,
  ) {
    // TODO: check media type
    if (contentManager.holders[index].isHorizontal) {
      final ContentHolderHorizontal image =
      contentManager.holders[index] as ContentHolderHorizontal;
      return HorizontalImage(image: image);
    } else {
      final ContentHolderVertical image =
      contentManager.holders[index] as ContentHolderVertical;
      return VerticalImages(image: image);
    }
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

  Widget buildExtraSpace(ContentManager contentManager, String? error) {
    if (error == null) {
      return const HorizontalLoader();
    }
    return Center(
      child: Text(error),
    ).padding(all: 20);
  }
}

