import 'package:flutter/material.dart';

class StaggeredAnimation extends StatefulWidget {
  @override
  _StaggeredAnimationState createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorsList = [
    Colors.green.shade300,
    Colors.green.shade500,
    Colors.green.shade700,
    Colors.green.shade900
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StaggeredAnimationBuilder(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          builder: (context, index) {
            return Container(
              width: 200,
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: colorsList[index],
              child: Center(
                child: FadeTransition(
                  opacity: _opacity,
                  child: Text('Widget $index'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StaggeredAnimationBuilder extends StatefulWidget {
  final int count;
  final Widget Function(BuildContext, int) builder;
  final Duration duration;
  final Duration delay;

  const StaggeredAnimationBuilder({
    this.count = 4,
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    this.delay = const Duration(milliseconds: 200),
  });

  @override
  _StaggeredAnimationBuilderState createState() =>
      _StaggeredAnimationBuilderState();
}

class _StaggeredAnimationBuilderState extends State<StaggeredAnimationBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration * widget.count,
    )..forward();
    _animations = List.generate(widget.count, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index * widget.delay.inMilliseconds) /
                _controller.duration!.inMilliseconds,
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(widget.count, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: widget.builder(context, index),
            );
          },
        );
      }),
    );
  }
}
