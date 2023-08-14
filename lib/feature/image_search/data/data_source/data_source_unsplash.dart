import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retrofit/retrofit.dart';

import '/di.dart';
import '/feature/image_search/domain/entities/errors.dart';
import '/feature/image_search/data/models/image_model.dart';
import '/feature/image_search/data/data_source/data_source_base.dart';

part 'data_source_unsplash.g.dart';


@RestApi(baseUrl: 'https://api.unsplash.com/')
abstract class _UnsplashApi {
  factory _UnsplashApi(Dio dio, {String baseUrl}) = __UnsplashApi;
  @GET('/search/photos')
  Future<ImageSearchModel> searchImages(
    @Query('query') String query,
    @Query('page') int page,
    [@Query('per_page') int perPage = 30]
  );
}

@Injectable(as: DataSourceBase)
class DataSourceUnsplash implements DataSourceBase{
  final Dio _dio = getIt<Dio>(instanceName: 'UnsplashClientModule');
  late final _UnsplashApi _api = _UnsplashApi(
    _dio,
  );
  SearchInfo? _searchInfo;

  @override
  Future<void> downloadImage(String url, String id) async {
    late String path;
    if (Platform.isAndroid) {
      path = '/storage/emulated/0/Download/$id.jpg';
    } else {
      path = '${(await getApplicationDocumentsDirectory()).path}/$id.jpg';
    }
    try {
      Response response = await _dio.download(url, path);
      if (response.statusCode != 200) {
        throw DownloadError(
          statusCode: response.statusCode!,
          message: 'Failed to download image',
        );
      }
    } on DioException catch (e) {
      throw DownloadError(
        statusCode: e.response?.statusCode ?? 0,
        message: e.message??'Unknown error',
      );
    }
  }

  @override
  Future<List<ImageModel>> searchImages(String query) async {
    assert(query.isNotEmpty, 'Query is empty');
    Future<ImageSearchModel> result = _api.searchImages(query, 1);
    try {
      ImageSearchModel searchResult = await result;
      _searchInfo = SearchInfo(
        query: query,
        maxPages: searchResult.totalPages,
        page: 1,
      );
      return searchResult.images;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Connection timeout',
          );
        case DioExceptionType.receiveTimeout:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Receive timeout',
          );
        case DioExceptionType.sendTimeout:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Send timeout',
          );
        case DioExceptionType.badResponse:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Response error: ${e.response?.statusCode}',
          );
        case DioExceptionType.cancel:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Request cancelled',
          );
        case DioExceptionType.badCertificate:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Bad certificate',
          );
        case DioExceptionType.connectionError:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Connection error',
          );
        case DioExceptionType.unknown:
          throw NetworkError(
            statusCode: e.response?.statusCode ?? 0,
            message: 'Unknown error',
          );
      }
    }
  }

  @override
  Future<List<ImageModel>> getNextPage() {
    assert(_searchInfo != null, 'Search info is null');
    assert(_searchInfo!.page < _searchInfo!.maxPages, 'No more pages');

    return _api.searchImages(_searchInfo!.query, _searchInfo!.page + 1)
      .then((value) {
        _searchInfo = _searchInfo!.copyWith(page: _searchInfo!.page + 1);
        return value.images;
      });
  }

  @override
  Future<int> getPagesCount() async {
    return _searchInfo!.maxPages;
  }
}
