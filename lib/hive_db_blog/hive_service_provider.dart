import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ui_app/hive_db_blog/hive_box_helper.dart';
import 'package:ui_app/hive_db_blog/hive_models/cat_model.dart';

class HiveServiceProvider extends ChangeNotifier {
  List<CatModel> catModelList = [];

  void addCat(CatModel catModel) async {
    Box<CatModel> catBox = await HiveBoxHelperClass.openCatBox();
    await catBox.put(catModel.name, catModel);
    print(catModelList);
    notifyListeners();
  }

  void getCats() async {
    Box<CatModel> catBox = await HiveBoxHelperClass.openCatBox();
    CatModel? catModel = catBox.get('foo');
    catModelList = catBox.values.toList();
    print(catModelList);
    notifyListeners();
  }

  void deleteCat(CatModel catModel) async {
    Box<CatModel> catBox = await HiveBoxHelperClass.openCatBox();
    await catBox.delete(catModel.name);
    notifyListeners();
  }
}
