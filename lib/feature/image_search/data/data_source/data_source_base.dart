import '/feature/image_search/data/models/image_model.dart';

abstract class DataSourceBase {
  Future<List<ImageModel>> searchImages(String query);
  Future<List<ImageModel>> getNextPage();
  Future<int> getPagesCount();
  Future<void> downloadImage(String url, String id);
}