import 'package:hive/hive.dart';
import 'package:ui_app/hive_db_blog/hive_models/cat_model.dart';

class HiveBoxHelperClass {
  static final HiveBoxHelperClass boxRepoHive = HiveBoxHelperClass._internal();
  factory HiveBoxHelperClass() {
    return boxRepoHive;
  }
  HiveBoxHelperClass._internal();

  static Future<Box<CatModel>> openCatBox() => Hive.openBox<CatModel>('cats');

  static Box<CatModel> getCatBox() => Hive.box<CatModel>('cats');
}
