import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp/di.dart';
import 'package:temp/feature/image_search/domain/repository/image_repository.dart';
import 'package:temp/feature/image_search/ui/widgets/images_list/image_network_loader.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([File])
import 'image_network_loader.mocks.dart';
import 'search_bar.mocks.dart';

class TestFile extends MockFile {
  final String _path;
  TestFile(this._path);
}

Future<File> _downloadFile(String url, String filename) async {
  File file = new File('/$filename');
  return file;
}

void main() {

  setUpAll(() {
    configureDependencies('test');
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
    getIt.unregister<ImageRepositoryBase>();
    getIt.registerLazySingleton<ImageRepositoryBase>(() => MockImageRepositoryBase());
  });


  testWidgets('image is downloaded', (WidgetTester tester) async {
    String rawImage = 'https://images.unsplash.com/photo-1542931380-c654087500b6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0ODMzMjR8MHwxfHNlYXJjaHwxMXx8YXxlbnwwfHx8fDE2OTExODQ1MjZ8MA&ixlib=rb-4.0.3&q=80&w=400';
    bool fileExists = false;

    when(
      getIt<ImageRepositoryBase>().downloadPhoto(rawImage, 'testId')
    ).thenAnswer((realInvocation) async {
      await IOOverrides.runZoned(() async {
        await _downloadFile(rawImage, 'testId');
      }, createFile: (String path) {
        fileExists = true;
        return TestFile(path);
      });
    });

    await tester.pumpWidget(
      MaterialApp(
        home: ImageNetworkLoader(
          url: 'https://images.unsplash.com/photo-1542931380-c654087500b6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0ODMzMjR8MHwxfHNlYXJjaHwxMXx8YXxlbnwwfHx8fDE2OTExODQ1MjZ8MA&ixlib=rb-4.0.3&q=80&w=400',
          urlRaw: rawImage,
          id: 'testId',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    await tester.pump(const Duration(milliseconds: 300));

    final gestureDetector = find.byType(GestureDetector);
    await tester.tap(gestureDetector);
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(gestureDetector);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));


    expect(fileExists, true);
  });
}
