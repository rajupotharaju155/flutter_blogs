import 'package:flutter/material.dart';

class ResponsiveExample extends StatelessWidget {
  const ResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    Size screnSize = MediaQuery.of(context).size;
    // return Column(
    //   children: [
    //     Container(
    //       width: screnSize.width > 600
    //           ? screnSize.width * 0.4
    //           : screnSize.width * 0.8,
    //       height: 100,
    //       color: Colors.blue,
    //     ),
    //   ],
    // );

    // return Scaffold(
    //   body: LayoutBuilder(builder: (context, contraints) {
    //     return screnSize.width > 400
    //         ? buildWideScreen()
    //         : buildPortraitScreen();
    //     // Container();
    //   }),
    // );

    return Scaffold(
      appBar: AppBar(),
      body: const SizedBox(
        width: 400,
        // height: 400,
        child: Flexible(
            child: Text(
          "This text will go to next line if there is no space",
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }

  Widget buildWideScreen() {
    return Row(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          color: Colors.red,
        ),
        Container(
          height: 100.0,
          width: 100.0,
          color: Colors.green,
        )
      ],
    );
  }

  Widget buildPortraitScreen() {
    return Column(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          color: Colors.orange,
        ),
      ],
    );
  }
}
