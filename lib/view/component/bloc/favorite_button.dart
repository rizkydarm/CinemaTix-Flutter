part of '../_component.dart';

class FavoriteMovieButton extends StatelessWidget {
  const FavoriteMovieButton({
    super.key,
    required this.movieId,
    this.size,
    this.initalColor,
  });

  final String movieId;
  final double? size;
  final Color? initalColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMovieCubit, BlocState>(
      builder: (context, state) {
        bool isStateFavorite = (state is SuccessState<List<FavoriteMovieEntity>>);
        bool isFavorite = isStateFavorite ? (state.data).any((data) => data.movieId == movieId) : false;
        return IconButton(
          onPressed: () {
            context.read<FavoriteMovieCubit>().toggle(movieId);
          },
          color: isFavorite ? Colors.red : initalColor,
          icon: Icon(Icons.favorite, size: size,),
        );
      }
    );
  }
}