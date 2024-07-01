
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([MovieUseCase])

void main() {
  
  late MockMovieUseCase mockMovieUseCase;
  late PlayingNowMovieCubit playingNowMovieCubit;
  late UpComingMovieCubit upComingMovieCubit;
  late MovieDetailCubit movieDetailCubit;

  setUp(() {
    mockMovieUseCase = MockMovieUseCase();
    playingNowMovieCubit = PlayingNowMovieCubit(mockMovieUseCase);
    upComingMovieCubit = UpComingMovieCubit(mockMovieUseCase);
    movieDetailCubit = MovieDetailCubit(mockMovieUseCase);
  });

  tearDown(() {
    playingNowMovieCubit.close();
    movieDetailCubit.close();
  });

  group('fetchMovies', () {
    
    final movieList = [
      MovieEntity(id: '1', title: 'Movie 1', overview: 'Overview 1', posterPath: 'path1', genres: const ['Action', 'Adventure']),
      MovieEntity(id: '2', title: 'Movie 2', overview: 'Overview 2', posterPath: 'path2', genres: const ['Action', 'Comedy']),
    ];

    blocTest<PlayingNowMovieCubit, BlocState>(
      'emits [loading, success] when fetchMovies is successful',
      build: () {

        when(mockMovieUseCase.getPlayingNowMovies())
            .thenAnswer((_) async => movieList);

        return playingNowMovieCubit;
      },
      act: (cubit) => cubit.fetchMovies(),
      expect: () => [
        LoadingState(),
        SuccessState<List<MovieEntity>>(movieList),
      ],
    );

    blocTest<UpComingMovieCubit, BlocState>(
      'emits [loading, error] when fetchMovies fails',
      build: () {
        when(mockMovieUseCase.getUpComingMovies())
            .thenThrow(Exception('Failed to fetch movies'));
        return upComingMovieCubit;
      },
      act: (cubit) => cubit.fetchMovies(),
      expect: () => [
        LoadingState(),
        const ErrorState('Exception: Failed to fetch movies'),
      ],
    );
  });

  group('fetchMovieDetail', () {
    final movieDetail = MovieDetailEntity(
      movie: MovieEntity(id: '1', title: 'Movie 1', overview: 'Overview 1', posterPath: 'path1', genres: const ['Action', 'Adventure'],),
      backdropPath: 'backdropPath',
      popularity: 9.0,
      releaseDate: DateTime(2020),
      tagline: 'Tagline 1',
      voteAverage: 8.0,
      productionCompanies: 'pro com 1'
    );

    blocTest<MovieDetailCubit, BlocState>(
      'emits [loading, success] when fetchMovieDetail is successful',
      build: () {
        when(mockMovieUseCase.getMovieDetailById('1'))
            .thenAnswer((_) async => movieDetail);
        return movieDetailCubit;
      },
      act: (cubit) => cubit.fetchMovieDetailById('1'),
      expect: () => [
        LoadingState(),
        SuccessState(movieDetail),
      ],
    );

    blocTest<MovieDetailCubit, BlocState>(
      'emits [loading, error] when fetchMovieDetail fails',
      build: () {
        when(mockMovieUseCase.getMovieDetailById('1'))
            .thenThrow(Exception('Failed to fetch movie detail'));
        return movieDetailCubit;
      },
      act: (cubit) => cubit.fetchMovieDetailById('1'),
      expect: () => [
        LoadingState(),
        const ErrorState('Exception: Failed to fetch movie detail'),
      ],
    );
  });
}

