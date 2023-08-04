import '/di.dart';
import '/utils/use_case_base.dart';
import '/feature/image_search/domain/repository/image_repository.dart';
import '/feature/image_search/domain/entities/image_entity.dart';

class GetNextPageUseCase implements UseCase<List<ImageEntity>, void> {
  GetNextPageUseCase();

  final ImageRepositoryBase _imageRepository = getIt<ImageRepositoryBase>();

  @override
  Future<List<ImageEntity>> call([_]) async {
    return _imageRepository.getNextPage();
  }
}

