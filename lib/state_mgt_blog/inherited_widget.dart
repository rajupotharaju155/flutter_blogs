import 'package:flutter/material.dart';

class Counter extends InheritedWidget {
  final int count;
  final VoidCallback increment;

  const Counter(
      {required this.count, required this.increment, required Widget child})
      : super(child: child);

  static Counter of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Counter>()!;

  @override
  bool updateShouldNotify(Counter oldWidget) => count != oldWidget.count;
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  void increment() {
    setState(() {
      Counter.of(context).count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build 1");
    return Counter(
      count: count,
      increment: increment,
      child: Scaffold(
        appBar: AppBar(title: const Text('Counter App')),
        body: CounterDisplay(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

//child Widget -> state is not passed directly
class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Counter.of(context);
    return Center(
      child: Text(
        'Count: ${counter.count}',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
