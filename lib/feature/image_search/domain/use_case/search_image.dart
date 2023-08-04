import 'dart:async';

import '/di.dart';
import '/utils/use_case_base.dart';
import '/feature/image_search/domain/entities/image_entity.dart';
import '/feature/image_search/domain/repository/image_repository.dart';


class SearchImageUseCase implements UseCase<List<ImageEntity>, String> {
  SearchImageUseCase();

  final ImageRepositoryBase _imageRepository = getIt<ImageRepositoryBase>();

  @override
  Future<List<ImageEntity>> call(String query) async {
    return _imageRepository.searchImages(query);
  }
}

