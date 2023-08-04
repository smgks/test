import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '/feature/image_search/domain/use_case/download_image.dart';

import 'loader.dart';

class ImageNetworkLoader extends StatefulWidget {
  final String url;
  final String urlRaw;
  final String id;

  const ImageNetworkLoader({
    required this.url,
    required this.urlRaw,
    required this.id,
    super.key,
  });

  @override
  State<ImageNetworkLoader> createState() => _ImageNetworkLoaderState();
}

class _ImageNetworkLoaderState extends State<ImageNetworkLoader> {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => _tryDownloadImage(context),
      child: Image.network(
        widget.url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: child,
            )
          : const Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              margin: EdgeInsets.zero,
              child: Loader(),
            ),
      ),
    );
  }

  void _tryDownloadImage(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    bool result = await DownloadImageUseCase().call(
      ImageDownloadParams(
        widget.urlRaw,
        widget.id,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_isDisposed) return;
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved as ${widget.id}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving image'),
          ),
        );
      }
    });
  }
}