import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterAppWithProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterModel>(
      create: (_) => CounterModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Counter App')),
        body: CounterDisplay(),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Provider.of<CounterModel>(context, listen: false).increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);
    return Center(
      child: Text(
        'Count: ${counter.count}',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
