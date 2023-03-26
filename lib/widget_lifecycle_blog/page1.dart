import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 1"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyPage()));
              },
              child: const Text("Next Page")),
        ),
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() {
    print("createState");
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  void _increment() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  late int _counter;
  @override
  void initState() {
    print("initState");
    _counter = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyPage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lifecycle Demo"),
      ),
      body: Container(
          child: Column(
        children: [
          Text(_counter.toString()),
          ElevatedButton(onPressed: _increment, child: const Text("Increment"))
        ],
      )),
    );
  }
}
