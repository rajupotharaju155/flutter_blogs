import 'package:flutter/material.dart';

class AppLifeCycleExample extends StatefulWidget {
  const AppLifeCycleExample({super.key});

  @override
  _AppLifeCycleExampleState createState() => _AppLifeCycleExampleState();
}

class _AppLifeCycleExampleState extends State<AppLifeCycleExample>
    with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _appLifecycleState = state;
      print(_appLifecycleState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Lifecycle Example'),
        ),
        body: Center(
          child: Text(
            'App is currently in $_appLifecycleState state.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
