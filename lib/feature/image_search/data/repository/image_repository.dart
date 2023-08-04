import 'package:injectable/injectable.dart';

import '/feature/image_search/data/data_source/data_source_base.dart';
import '/feature/image_search/data/data_source/data_source_unsplash.dart';
import '/feature/image_search/domain/entities/image_entity.dart';
import '/feature/image_search/domain/repository/image_repository.dart';


@LazySingleton(as: ImageRepositoryBase)
class ImageRepositoryImpl implements ImageRepositoryBase {
  final DataSourceBase _dataSource = DataSourceUnsplash();

  @override
  Future<void> downloadPhoto(String url, String id) {
    return _dataSource.downloadImage(url, id);
  }

  @override
  Future<List<ImageEntity>> searchImages(String query) {
    return _dataSource.searchImages(query);
  }

  @override
  Future<List<ImageEntity>> getNextPage() {
    return _dataSource.getNextPage();
  }

  @override
  Future<int> getPagesCount() {
    return _dataSource.getPagesCount();
  }
}
