import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'image_network_loader.dart';
import '/feature/image_search/ui/view_models/image_manager.dart';

class HorizontalImage extends StatelessWidget {
  const HorizontalImage({
    super.key,
    required this.image,
  });

  final ContentHolderHorizontal image;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 256,
      ),
      child: AspectRatio(
        aspectRatio: ((156*2)+18)/200,
        child: ImageNetworkLoader(
          url: image.content.urlSmall,
          urlRaw: image.content.urlRaw,
          id: image.content.id,
        ),
      ),
    ).paddingDirectional(vertical: 10);
  }
}