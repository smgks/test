import '/di.dart';
import '/utils/use_case_base.dart';
import '/feature/image_search/domain/repository/image_repository.dart';


class GetPagesCountUseCase implements UseCase<int, void> {
  GetPagesCountUseCase();

  final ImageRepositoryBase _imageRepository = getIt<ImageRepositoryBase>();

  @override
  Future<int> call([_]) async {
    return _imageRepository.getPagesCount();
  }
}

