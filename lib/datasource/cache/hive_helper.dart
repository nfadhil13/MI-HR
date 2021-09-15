import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/datasource/cache/model/user_entity.dart';
class HiveHelper {


  static Future<void> init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(UserEntityAdapter());
  }

}
