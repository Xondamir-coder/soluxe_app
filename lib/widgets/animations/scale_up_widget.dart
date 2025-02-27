import 'package:flutter/material.dart';

class ScaleUpWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginScale;
  final double endScale;
  final Curve curve;
  final int delay;
  final bool isFading;

  const ScaleUpWidget({
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.ease,
    this.delay = 0,
  }) : isFading = false;

  const ScaleUpWidget.fade({
    super.key,
    required this.child,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.ease,
    this.delay = 0,
  }) : isFading = true;

  @override
  State<ScaleUpWidget> createState() => _ScaleUpWidgetState();
}

class _ScaleUpWidgetState extends State<ScaleUpWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    if (widget.isFading) {
      _fadeAnimation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
    }

    if (widget.delay > 0) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );

    if (widget.isFading && _fadeAnimation != null) {
      animatedChild = FadeTransition(
        opacity: _fadeAnimation!,
        child: animatedChild,
      );
    }

    return animatedChild;
  }
}
