class ImageEntity {
  final String id;
  final int width;
  final int height;
  final String urlSmall;
  final String urlRaw;

  bool get isHorizontal => width > height;

  ImageEntity({
    required this.id,
    required this.urlSmall,
    required this.urlRaw,
    required this.width,
    required this.height,
  });
}
