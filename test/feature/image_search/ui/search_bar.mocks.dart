// Mocks generated by Mockito 5.4.2 from annotations
// in temp/test/feature/image_search/ui/search_bar.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:temp/feature/image_search/domain/entities/image_entity.dart'
    as _i4;
import 'package:temp/feature/image_search/domain/repository/image_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ImageRepositoryBase].
///
/// See the documentation for Mockito's code generation for more information.
class MockImageRepositoryBase extends _i1.Mock
    implements _i2.ImageRepositoryBase {
  @override
  _i3.Future<List<_i4.ImageEntity>> searchImages(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchImages,
          [query],
        ),
        returnValue:
            _i3.Future<List<_i4.ImageEntity>>.value(<_i4.ImageEntity>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.ImageEntity>>.value(<_i4.ImageEntity>[]),
      ) as _i3.Future<List<_i4.ImageEntity>>);
  @override
  _i3.Future<List<_i4.ImageEntity>> getNextPage() => (super.noSuchMethod(
        Invocation.method(
          #getNextPage,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.ImageEntity>>.value(<_i4.ImageEntity>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.ImageEntity>>.value(<_i4.ImageEntity>[]),
      ) as _i3.Future<List<_i4.ImageEntity>>);
  @override
  _i3.Future<void> downloadPhoto(
    String? url,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #downloadPhoto,
          [
            url,
            id,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<int> getPagesCount() => (super.noSuchMethod(
        Invocation.method(
          #getPagesCount,
          [],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}
