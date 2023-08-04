import '/feature/image_search/domain/entities/image_entity.dart';

class ImageSearchModel {
  final int totalImages;
  final int totalPages;
  final List<ImageModel> images;

  const ImageSearchModel({
    required this.totalImages,
    required this.totalPages,
    required this.images,
  });


  factory ImageSearchModel.fromJson(Map<String, dynamic> map) {
    return ImageSearchModel(
      totalImages: map['total'] as int,
      totalPages: map['total_pages'] as int,
      images: (map['results'] as List).map(
        (e) => ImageModel.fromJson(e as Map<String, dynamic>),
      ).toList(),
    );
  }
}

class ImageModel extends ImageEntity {
  ImageModel({
    required super.id,
    required super.urlSmall,
    required super.urlRaw,
    required super.width,
    required super.height
  });


  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as String,
      width: map['width'] as int,
      height: map['height'] as int,
      urlSmall: map['urls']['small'] as String,
      urlRaw: map['urls']['raw'] as String,
    );
  }
}

class SearchInfo {
  final String query;
  final int maxPages;
  final int page;

  const SearchInfo({
    required this.query,
    required this.maxPages,
    required this.page,
  });

  SearchInfo copyWith({
    String? query,
    int? maxPages,
    int? page,
  }) {
    return SearchInfo(
      query: query ?? this.query,
      maxPages: maxPages ?? this.maxPages,
      page: page ?? this.page,
    );
  }
}