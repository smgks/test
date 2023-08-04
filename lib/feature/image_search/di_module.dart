import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '/credentials.dart';

@module
abstract class ImageSearchModule {
  @Named('UnsplashClientModule')
  @injectable
  Dio get dioProd => Dio(BaseOptions(
    headers: {
      'Authorization': 'Client-ID $unsplashCredentials'
    },
    baseUrl: 'https://api.unsplash.com/',
  ));
}