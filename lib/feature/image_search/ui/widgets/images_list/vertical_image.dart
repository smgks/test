
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '/feature/image_search/ui/bloc/image_search_bloc.dart';
import '/feature/image_search/ui/view_models/image_manager.dart';
import '/feature/image_search/ui/widgets/images_list/image_network_loader.dart';
import '/feature/image_search/ui/widgets/images_list/vertical_loader.dart';

class VerticalImages extends StatelessWidget {
  const VerticalImages({
    super.key,
    required this.image,
  });

  final ImageHolderVertical image;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 256,
      ),
      child: AspectRatio(
        aspectRatio: ((156*2)+18)/200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ImageNetworkLoader(
                url: image.images[0].urlSmall,
                urlRaw: image.images[0].urlRaw,
                id: image.images[0].id,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
            if (image.images.length > 1)
              Expanded(
                child: ImageNetworkLoader(
                  url: image.images[1].urlSmall,
                  urlRaw: image.images[1].urlRaw,
                  id: image.images[1].id,
                ),
              )
            else if (shouldPaintLoader(context))
              const VerticalLoader()
            else
              const Expanded(
                child: SizedBox(),
              ),
          ],
        ),
      ),
    ).paddingDirectional(vertical: 10);
  }

  bool shouldPaintLoader(BuildContext context) =>
      context.read<ImageSearchBloc>().state is ImageSearchResult && !(
          context.read<ImageSearchBloc>().state as ImageSearchResult
      ).isReachedEnd;
}