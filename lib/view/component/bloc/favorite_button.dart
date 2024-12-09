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
        return IconButton(
          onPressed: () {
            context.read<FavoriteMovieCubit>().toggle(movieId);
          },
          color: (state is SuccessState<String>) ? (state.data == movieId) ? Colors.red : initalColor : initalColor,
          icon: Icon(Icons.favorite, size: size,),
        );
      }
    );
  }
}