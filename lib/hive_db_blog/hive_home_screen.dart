import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_app/hive_db_blog/hive_service_provider.dart';
import 'package:ui_app/hive_db_blog/widgets/build_alert_dialog.dart';

class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  var provider;
  void showAddCatDialog() {
    showDialog(context: context, builder: (context) => const AddCatAlert());
  }

  @override
  void initState() {
    provider = Provider.of<HiveServiceProvider>(context, listen: false);
    provider.getCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hive Local Cat Database'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showAddCatDialog,
          child: const Icon(Icons.add),
        ),
        body: Consumer<HiveServiceProvider>(
            builder: (context, HiveServiceProvider, widget) {
          if (HiveServiceProvider.catModelList.isEmpty) {
            return const Center(
              child: Text("No Cats found"),
            );
          }
          return ListView.builder(
              itemCount: HiveServiceProvider.catModelList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: const Icon(
                    Icons.pets,
                    color: Colors.purple,
                  ),
                  title: Text(
                    HiveServiceProvider.catModelList[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                      "Age ${HiveServiceProvider.catModelList[index].age}\nGender:  ${HiveServiceProvider.catModelList[index].isMale ? 'Male' : 'Female'}"),
                  trailing: IconButton(
                      onPressed: () {
                        provider
                            .deleteCat(HiveServiceProvider.catModelList[index]);
                        provider.getCats();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              });
        }));
  }
}
