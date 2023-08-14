import 'package:injectable/injectable.dart';

import '/feature/image_search/data/data_source/data_source_base.dart';
import '/feature/image_search/domain/entities/image_entity.dart';
import '/feature/image_search/domain/repository/image_repository.dart';


@LazySingleton(as: ImageRepositoryBase)
class ImageRepositoryImpl implements ImageRepositoryBase {
  final DataSourceBase _dataSource;

  ImageRepositoryImpl(this._dataSource);
  // TODO: local repository
  // TODO: conncetion checker
  bool get isConnected => true;

  @override
  Future<void> downloadPhoto(String url, String id) {
    if (isConnected) {
      return _dataSource.downloadImage(url, id);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<ImageEntity>> searchImages(String query) {
    if (isConnected) {
      return _dataSource.searchImages(query);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<ImageEntity>> getNextPage() {
    if (isConnected) {
      return _dataSource.getNextPage();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<int> getPagesCount() {
    if (isConnected) {
      return _dataSource.getPagesCount();
    } else {
      throw UnimplementedError();
    }
  }
}
