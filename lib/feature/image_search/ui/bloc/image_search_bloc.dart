import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/feature/image_search/domain/entities/image_entity.dart';

import '/utils/debouncer.dart';
import '/feature/image_search/domain/entities/errors.dart';
import '/feature/image_search/domain/use_case/get_pages_count.dart';
import '/feature/image_search/domain/use_case/get_next_page.dart';
import '/feature/image_search/domain/use_case/search_image.dart';
import '/feature/image_search/ui/view_models/image_manager.dart';

part 'image_search_event.dart';
part 'image_search_state.dart';

class ImageSearchBloc extends Bloc<ImageSearchEvent, ImageSearchState> {
  final Debouncer _debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );
  bool _isSearching = false;

  ImageSearchBloc() : super(ImageSearchInitial()) {
    on<ChangeSearchQueryEvent>(onChangeSearchQuery);

    on<ChangeSearchQueryExecuteEvent>(onChangeSearchQueryExecute);

    on<LoadNextPageEvent>(onLoadNextPage);
  }

  @override
  Future<void> close() async {
    await super.close();
    _debouncer.dispose();
  }

  FutureOr<void> onLoadNextPage(event, emit) async {
    if (state is ImageSearchResult) {
      if ((state as ImageSearchResult).currentPage >=
          (state as ImageSearchResult).pages) {
        return;
      }
    }
    try {
      await GetNextPageUseCase().call().then((value) {
        if (_isSearching) {
          return;
        }
        ImageSearchResult newState = ImageSearchResult(
          query: (state as ImageSearchResult).query,
          imageManager: (state as ImageSearchResult).imageManager,
          pages: (state as ImageSearchResult).pages,
          currentPage: (state as ImageSearchResult).currentPage + 1,
        );
        newState.imageManager.addAll(value);
        emit(newState);
      });
    } on NetworkError catch (e) {
      ImageSearchResult newState = ImageSearchResult(
        query: (state as ImageSearchResult).query,
        imageManager: (state as ImageSearchResult).imageManager,
        pages: (state as ImageSearchResult).currentPage,
        currentPage: (state as ImageSearchResult).currentPage,
        error: e.message,
      );
      emit(
        newState,
      );
    }
  }

  FutureOr<void> onChangeSearchQueryExecute(event, emit) async {
    try {
      await SearchImageUseCase().call(event.query).then((value) async {
        int pages = await GetPagesCountUseCase().call();
        ImageSearchResult newState = ImageSearchResult(
          query: event.query,
          pages: pages,
        );
        newState.imageManager.addAll(value);
        _isSearching = false;
        emit(newState);
      });
    } on NetworkError catch (e) {
      emit(
        ImageSearchError(e.message),
      );
    }
  }

  FutureOr<void> onChangeSearchQuery(event, emit) async {
    if (event.query.isEmpty) {
      return;
    }
    _debouncer.pushTask(() async {
      _isSearching = true;
      add(ChangeSearchQueryExecuteEvent(event.query));
    });
  }
}
