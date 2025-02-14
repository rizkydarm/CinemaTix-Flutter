import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:mockito/mockito.dart';

class MockPlayingNowMovieCubit extends Mock implements PlayingNowMovieCubit {}
class MockUpComingMovieCubit extends Mock implements UpComingMovieCubit {}
class MockFavoriteMovieCubit extends Mock implements FavoriteMovieCubit {}

void main() {
  group('HomePage', () {

    late MockPlayingNowMovieCubit mockPlayingNowMovieCubit;
    late MockUpComingMovieCubit mockUpComingMovieCubit;
    late MockFavoriteMovieCubit mockFavoriteMovieCubit;

    setUp(() {
      mockPlayingNowMovieCubit = MockPlayingNowMovieCubit()..fetchMovies(max: 5);
      mockUpComingMovieCubit = MockUpComingMovieCubit()..fetchMovies(max: 5);
      mockFavoriteMovieCubit = MockFavoriteMovieCubit();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PlayingNowMovieCubit>(
              create: (_) => mockPlayingNowMovieCubit,
            ),
            BlocProvider<UpComingMovieCubit>(
              create: (_) => mockUpComingMovieCubit,
            ),
            BlocProvider<FavoriteMovieCubit>(
              create: (_) => mockFavoriteMovieCubit,
            ),
          ],
          child: const HomePage(),
        ),
      );
    }

    testWidgets('should render ListTile for Upcoming Movies', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Upcoming Movies'), findsOneWidget);

      final listTile = tester.widget<ListTile>(find.text('Upcoming Movies'));
      expect(listTile.onTap, isNotNull);
    });

    testWidgets('should render ListTile for Playing Now Movies', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Playing Now Movies'), findsOneWidget);

      final listTile = tester.widget<ListTile>(find.text('Playing Now Movies'));
      expect(listTile.onTap, isNotNull);
    });
  });
}
