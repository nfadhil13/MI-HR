
import 'package:hive/hive.dart';
import 'package:movie_app/datasource/cache/hive_sequence.dart';

part 'user_entity.g.dart';

@HiveType(typeId: HiveSequence.User)
class UserEntity {

  static final boxName = "user-entity";

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String jobTitle;

  @HiveField(3)
  final String imageProfileURL;


  @HiveField(4)
  final bool isImageFromURL;

  UserEntity(this.id, this.name, this.jobTitle, this.imageProfileURL,
      this.isImageFromURL);
}