import 'dart:async';

import '/di.dart';
import '/utils/use_case_base.dart';
import '/feature/image_search/domain/repository/image_repository.dart';


class DownloadImageUseCase implements UseCase<void, ImageDownloadParams> {
  DownloadImageUseCase();

  final ImageRepositoryBase _imageRepository = getIt<ImageRepositoryBase>();

  @override
  Future<bool> call(ImageDownloadParams params) async {
    try {
      await _imageRepository.downloadPhoto(params.url, params.id);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ImageDownloadParams {
  final String url;
  final String id;

  ImageDownloadParams(this.url, this.id);
}