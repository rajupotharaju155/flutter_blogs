import 'package:flutter/material.dart';

class InteractiveAnimation extends StatefulWidget {
  // const InteractiveAnimation({super.key});

  @override
  _InteractiveAnimationState createState() => _InteractiveAnimationState();
}

class _InteractiveAnimationState extends State<InteractiveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((value) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          child: AnimatedBuilder(
            animation: _scale,
            builder: (context, child) {
              return Transform.scale(
                scale: _scale.value,
                child: child,
              );
            },
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.orangeAccent,
            ),
          ),
        ),
      ),
    );
  }
}
