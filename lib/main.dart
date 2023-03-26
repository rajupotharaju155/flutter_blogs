import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ui_app/hive_db_blog/hive_box_helper.dart';
import 'package:ui_app/hive_db_blog/hive_home_screen.dart';
import 'package:ui_app/hive_db_blog/hive_models/cat_model.dart';
import 'package:ui_app/hive_db_blog/hive_service_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatModelAdapter());
  // Hive.openBox<CatModel>('cats');
  HiveBoxHelperClass.openCatBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HiveServiceProvider>(
      create: (context) => HiveServiceProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          // scaffoldBackgroundColor: Colors.grey[200]
        ),
        home: const HiveHomeScreen(),
      ),
    );
  }
}
