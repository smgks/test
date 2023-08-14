part of 'image_search_bloc.dart';

@immutable
abstract class ImageSearchState {}

class ImageSearchResult extends ImageSearchState {
  final ContentManager imageManager;
  final String query;
  final int pages;
  final int currentPage;
  final String? error;
  bool get isReachedEnd => currentPage >= pages;

  ImageSearchResult({
    this.query = '',
    this.error,
    required this.pages,
    this.currentPage = 1,
    ContentManager? imageManager,
  }) : imageManager = imageManager ?? ContentManager<ImageEntity>();
}

class ImageSearchLoading extends ImageSearchState {

}

class ImageSearchInitial extends ImageSearchState {

}
class ImageSearchError extends ImageSearchState {
  final String error;

  ImageSearchError(this.error);
}
