import '/feature/image_search/domain/entities/image_entity.dart';

class ImageManager {
  ImageManager();

  final List<ImageHolderBase> holders = [];
  int get length => holders.length;

  int? _freeVerticalIndex;

  bool get isPageComplete => _freeVerticalIndex == null;


  void addAll(List<ImageEntity> images) {
    for (var image in images) {
      _add(image);
    }
    if (_freeVerticalIndex != null) {
      var temp = holders[_freeVerticalIndex!] as ImageHolderVertical;
      holders.removeAt(_freeVerticalIndex!);
      _freeVerticalIndex = holders.length;
      holders.add(temp);
    }
  }

  void _add(ImageEntity image) {
    if (image.isHorizontal) {
      holders.add(ImageHolderHorizontal(image: image));
    } else {
      if (_freeVerticalIndex == null) {
        holders.add(
          ImageHolderVertical(
            imageInitial: image,
          ),
        );
        _freeVerticalIndex = holders.length - 1;
      } else {
        (holders[_freeVerticalIndex!] as ImageHolderVertical).add(image);
        _freeVerticalIndex = null;
      }
    }

  }
}

abstract class ImageHolderBase {
  bool get isHorizontal;
}

class ImageHolderVertical extends ImageHolderBase {
  ImageHolderVertical({
    required ImageEntity imageInitial,
  }) : images = [imageInitial];
  final List<ImageEntity> images;

  void add(ImageEntity image) {
    images.add(image);
  }

  @override
  bool get isHorizontal => false;
}

class ImageHolderHorizontal extends ImageHolderBase {
  ImageHolderHorizontal({
    required this.image,
  });
  final ImageEntity image;

  @override
  bool get isHorizontal => true;
}