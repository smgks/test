part of 'image_search_bloc.dart';

@immutable
abstract class ImageSearchEvent {}

class ChangeSearchQueryEvent extends ImageSearchEvent {
  final String query;

  ChangeSearchQueryEvent(this.query);
}

class ChangeSearchQueryExecuteEvent extends ImageSearchEvent {
  final String query;

  ChangeSearchQueryExecuteEvent(this.query);
}

class LoadNextPageEvent extends ImageSearchEvent {}