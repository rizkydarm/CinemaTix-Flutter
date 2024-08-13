import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/page/_page.dart';

class MockPlayingNowMovieCubit extends Mock implements PlayingNowMovieCubit {}
class MockUpComingMovieCubit extends Mock implements UpComingMovieCubit {}

void main() {
  
  late MockPlayingNowMovieCubit mockPlayingNowMovieCubit;
  late MockUpComingMovieCubit mockUpComingMovieCubit;

  setUp(() {
    mockPlayingNowMovieCubit = MockPlayingNowMovieCubit();
    mockUpComingMovieCubit = MockUpComingMovieCubit();
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
          )
        ],
        child: const HomePage(),
      ),
    );
  }

  testWidgets('Display loading indicator while fetching data', (WidgetTester tester) async {
    when(mockPlayingNowMovieCubit.state).thenReturn(LoadingState());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Display list data when loaded', (WidgetTester tester) async {
    final list1 = ['Item 1', 'Item 2'];
    final list2 = ['Item A', 'Item B'];
    when(mockPlayingNowMovieCubit.state).thenReturn(SuccessState(list1));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byKey(const Key('list1')), findsOneWidget);
    expect(find.byKey(const Key('list2')), findsOneWidget);
    for (var item in list1) {
      expect(find.text(item), findsOneWidget);
    }
    for (var item in list2) {
      expect(find.text(item), findsOneWidget);
    }
  });

  testWidgets('Display error message when there is an error', (WidgetTester tester) async {
    when(mockPlayingNowMovieCubit.state).thenReturn(const ErrorState('Error message'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error message'), findsOneWidget);
  });
}
