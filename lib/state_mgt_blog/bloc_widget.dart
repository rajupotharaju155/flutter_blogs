import 'dart:async';

import 'package:flutter/material.dart';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {
  int increment;
  IncrementEvent({required this.increment});
}

class CounterBloc {
  int _count = 0;
  final _counterController = StreamController<int>();
  Stream<int> get counterStream => _counterController.stream;

  void dispose() {
    _counterController.close();
  }

  void mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _count += event.increment;
      _counterController.add(_count);
    }
  }
}

class CounterAppWithBloc extends StatelessWidget {
  final _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: StreamBuilder<int>(
        stream: _counterBloc.counterStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text(
              'Count: ${snapshot.data}',
              style: const TextStyle(fontSize: 24),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _counterBloc.mapEventToState(IncrementEvent(increment: 6)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
