import 'package:flutter/material.dart';

class InstagramTransitionWrapper extends StatefulWidget {
  final Widget child;

  const InstagramTransitionWrapper({super.key, required this.child});

  @override
  State<InstagramTransitionWrapper> createState() => _InstagramTransitionWrapperState();
}

class _InstagramTransitionWrapperState extends State<InstagramTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _scaleAnimation = Tween<double>(begin: 0.98, end: 1.0).animate(curved);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
