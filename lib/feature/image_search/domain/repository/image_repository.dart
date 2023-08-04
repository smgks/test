import '/feature/image_search/domain/entities/image_entity.dart';

abstract class ImageRepositoryBase {
  Future<List<ImageEntity>> searchImages(String query);
  Future<List<ImageEntity>> getNextPage();
  Future<void> downloadPhoto(String url, String id);
  Future<int> getPagesCount();
}