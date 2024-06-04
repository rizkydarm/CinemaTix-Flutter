import 'package:objectbox/objectbox.dart';

@Entity()
class Person {

  const Person({
    required this.id, 
    required this.name,
  });
  
  @Id()
  final int id;

  final String name;
}

@Entity()
class LikedMovieEntity {

  LikedMovieEntity({
    required this.id,
    required this.movieID,
    this.isLiked = false,
  });

  @Id()
  final int id;
  
  final String movieID;

  final bool isLiked;

  Map<String, dynamic> toJson() => {
    'movieID': movieID,
    'isLiked': isLiked,
  };
  
}
