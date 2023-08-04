import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import '/feature/image_search/ui/view_models/image_manager.dart';
import '/feature/image_search/ui/widgets/images_list/image_network_loader.dart';

class HorizontalImage extends StatelessWidget {
  const HorizontalImage({
    super.key,
    required this.image,
  });

  final ImageHolderHorizontal image;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 256,
      ),
      child: AspectRatio(
        aspectRatio: ((156*2)+18)/200,
        child: ImageNetworkLoader(
          url: image.image.urlSmall,
          urlRaw: image.image.urlRaw,
          id: image.image.id,
        ),
      ),
    ).paddingDirectional(vertical: 10);
  }
}