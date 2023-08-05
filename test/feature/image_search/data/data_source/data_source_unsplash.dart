import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:temp/di.dart';
import 'package:temp/feature/image_search/data/data_source/data_source_unsplash.dart';
import 'package:temp/feature/image_search/data/models/image_model.dart';

import 'api_data.dart';



void main() {
  late DataSourceUnsplash dataSourceUnsplash;
  late final DioAdapter dioAdapter;
  configureDependencies('test');
  TestWidgetsFlutterBinding.ensureInitialized();
  getIt.unregister<Dio>(instanceName: 'UnsplashClientModule');
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
    instanceName: 'UnsplashClientModule',
  );

  dataSourceUnsplash = DataSourceUnsplash();
  dioAdapter = DioAdapter(dio: getIt<Dio>(instanceName: 'UnsplashClientModule'));
  dioAdapter.onGet(
    '/search/photos',
    queryParameters: {'query': 'qwerty', 'page': '1'},
    (server) {
      server.reply(200, apiSearchDataSnippet);
    }
  );
  dioAdapter.onGet(
    '/search/photos',
    queryParameters: {'query': 'qwerty', 'page': '2'},
    (server) {
      server.reply(200, apiNextPageDataSnippet);
    }
  );

  test('search test', () async {
    List<ImageModel> images = await dataSourceUnsplash.searchImages('qwerty');
    expect(images.first.id, 'oXV3bzR7jxI');
    expect(images.first.height, 3744);
    expect(images.first.width, 5616);
    expect(images.first.urlSmall, 'https://images.unsplash.com/photo-1534644107580-3a4dbd494a95?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0ODMzMjR8MHwxfHNlYXJjaHwxfHx0ZXN0fGVufDB8fHx8MTY5MTExODM5M3ww&ixlib=rb-4.0.3&q=80&w=400');
    expect(images.length, 10);
    expect(images.first.urlRaw, 'https://images.unsplash.com/photo-1534644107580-3a4dbd494a95?ixid=M3w0ODMzMjR8MHwxfHNlYXJjaHwxfHx0ZXN0fGVufDB8fHx8MTY5MTExODM5M3ww&ixlib=rb-4.0.3');
    expect(images.last.id, 'cbEvoHbJnIE');
  });
}