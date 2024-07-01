import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mock Cubit
class MockPlayingNowMovieCubit extends Mock implements PlayingNowMovieCubit {}
class MockUpComingMovieCubit extends Mock implements UpComingMovieCubit {}

void main() {
  
  late MockPlayingNowMovieCubit mockPlayingNowMovieCubit;
  late MockUpComingMovieCubit upComingMovieCubit;

  setUp(() {
    mockPlayingNowMovieCubit = MockPlayingNowMovieCubit();
    upComingMovieCubit = MockUpComingMovieCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PlayingNowMovieCubit>(
        create: (_) => mockPlayingNowMovieCubit,
        child: const HomePage(),
      ),
    );
  }

  testWidgets('displays loading indicator while fetching data', (WidgetTester tester) async {
    when(mockPlayingNowMovieCubit.state).thenReturn(LoadingState());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays list data when loaded', (WidgetTester tester) async {
    final list1 = ['Item 1', 'Item 2'];
    final list2 = ['Item A', 'Item B'];
    when(mockPlayingNowMovieCubit.state).thenReturn(SuccessState(list1));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byKey(Key('list1')), findsOneWidget);
    expect(find.byKey(Key('list2')), findsOneWidget);
    for (var item in list1) {
      expect(find.text(item), findsOneWidget);
    }
    for (var item in list2) {
      expect(find.text(item), findsOneWidget);
    }
  });

  testWidgets('displays error message when there is an error', (WidgetTester tester) async {
    when(mockPlayingNowMovieCubit.state).thenReturn(const ErrorState('Error message'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('triggers fetchLists when button is pressed', (WidgetTester tester) async {
    when(mockPlayingNowMovieCubit.state).thenReturn(InitialState());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    verify(mockPlayingNowMovieCubit.fetchMovies()).called(1);
  });
}
