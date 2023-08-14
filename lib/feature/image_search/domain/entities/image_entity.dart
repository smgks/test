import '/feature/image_search/domain/entities/media_content.dart';

class ImageEntity extends MediaContentEntity {
  final String id;
  final int width;
  final int height;
  final String urlSmall;
  final String urlRaw;

  ImageEntity({
    required this.id,
    required this.urlSmall,
    required this.urlRaw,
    required this.width,
    required this.height,
  });

  @override
  bool get isHorizontal => width > height;
}
