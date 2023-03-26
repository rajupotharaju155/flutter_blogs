import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_app/hive_db_blog/hive_models/cat_model.dart';
import 'package:ui_app/hive_db_blog/hive_service_provider.dart';

class AddCatAlert extends StatefulWidget {
  const AddCatAlert({super.key});

  @override
  State<AddCatAlert> createState() => _AddCatAlertState();
}

class _AddCatAlertState extends State<AddCatAlert> {
  bool _isMale = true;
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _ageEditingController = TextEditingController();

  void submit() {
    var catModel = CatModel(_nameEditingController.text.trim(),
        _ageEditingController.text.trim(), _isMale);
    var provider = Provider.of<HiveServiceProvider>(context, listen: false);
    provider.addCat(catModel);
    provider.getCats();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Cat"),
      content: SizedBox(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                label: Text("Name"),
                // hintText: "Id",
              ),
            ),
            TextField(
              controller: _ageEditingController,
              decoration: const InputDecoration(
                label: Text("Age"),
                // hintText: "Name",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Cat Gender"),
            RadioListTile(
                title: const Text("Male"),
                value: true,
                groupValue: _isMale,
                onChanged: (value) {
                  setState(() {
                    _isMale = value as bool;
                  });
                }),
            RadioListTile(
                title: const Text("Female"),
                value: false,
                groupValue: _isMale,
                onChanged: (value) {
                  setState(() {
                    _isMale = value as bool;
                  });
                }),
            const Spacer(),
            SizedBox(
                width: double.infinity,
                child:
                    ElevatedButton(onPressed: submit, child: const Text("Add")))
          ],
        ),
      ),
    );
  }
}
