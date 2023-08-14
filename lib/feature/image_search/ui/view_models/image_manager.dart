import 'package:temp/feature/image_search/domain/entities/media_content.dart';

class ContentManager<T extends MediaContentEntity> {
  ContentManager();

  final List<ContentHolderBase<T>> holders = [];
  int get length => holders.length;

  int? _freeVerticalIndex;

  bool get isPageComplete => _freeVerticalIndex == null;


  void addAll(List<T> images) {
    for (var image in images) {
      _add(image);
    }
    if (_freeVerticalIndex != null) {
      var temp = holders[_freeVerticalIndex!] as ContentHolderVertical<T>;
      holders.removeAt(_freeVerticalIndex!);
      _freeVerticalIndex = holders.length;
      holders.add(temp);
    }
  }

  void _add(T image) {
    if (image.isHorizontal) {
      holders.add(ContentHolderHorizontal<T>(content: image));
    } else {
      if (_freeVerticalIndex == null) {
        holders.add(
          ContentHolderVertical<T>(
            contentInitial: image,
          ),
        );
        _freeVerticalIndex = holders.length - 1;
      } else {
        (holders[_freeVerticalIndex!] as ContentHolderVertical).add(image);
        _freeVerticalIndex = null;
      }
    }
  }
}

abstract class ContentHolderBase<T> {
  bool get isHorizontal;
}

class ContentHolderVertical<T> extends ContentHolderBase<T> {
  ContentHolderVertical({
    required T contentInitial,
  }) : content = [contentInitial];
  final List<T> content;

  void add(T image) {
    content.add(image);
  }

  @override
  bool get isHorizontal => false;
}

class ContentHolderHorizontal<T> extends ContentHolderBase<T> {
  ContentHolderHorizontal({
    required this.content,
  });
  final T content;

  @override
  bool get isHorizontal => true;
}