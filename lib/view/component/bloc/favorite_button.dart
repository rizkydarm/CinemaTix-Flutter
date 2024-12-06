part of '../_component.dart';

class FavoriteMovieButton extends StatelessWidget {
  const FavoriteMovieButton({
    super.key,
    required this.movieId,
    this.size,
  });

  final String movieId;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMovieCubit, BlocState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<FavoriteMovieCubit>().toggle(movieId);
          },
          color: (state is SuccessState<String>) ? (state.data == movieId) ? Colors.red : null : null,
          icon: Icon(Icons.favorite, size: size,),
        );
      }
    );
  }
}