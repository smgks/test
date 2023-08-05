import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp/di.dart';
import 'package:temp/feature/image_search/domain/repository/image_repository.dart';
import 'package:temp/feature/image_search/ui/bloc/image_search_bloc.dart';
import 'package:temp/feature/image_search/ui/widgets/search_bar.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


@GenerateNiceMocks([MockSpec<ImageRepositoryBase>()])
import 'search_bar.mocks.dart';

void main() {

  setUpAll(() {
    configureDependencies('test');
    TestWidgetsFlutterBinding.ensureInitialized();
    getIt.unregister<ImageRepositoryBase>();
    getIt.registerLazySingleton<ImageRepositoryBase>(() => MockImageRepositoryBase());

  });
  
  testWidgets('Test search delay', (WidgetTester tester) async {
    final ImageSearchBloc bloc = ImageSearchBloc();
    bool debounced = true;
    when(
      getIt<ImageRepositoryBase>().searchImages('t')
    ).thenAnswer((realInvocation) async {
      debounced = false;
      return [];
    });
    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: const MaterialApp(
          home: CustomScrollView(
            slivers: [
              SearchAppBar(),
            ],
          )
        ),
      ),
    );

    expect(find.byType(SearchAppBar), findsOneWidget);
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 't');
    await tester.pump(const Duration(milliseconds: 10));
    await tester.enterText(textField, 'test');
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(milliseconds: 500));
    bloc.close();
    expect(debounced, true);
  });
}