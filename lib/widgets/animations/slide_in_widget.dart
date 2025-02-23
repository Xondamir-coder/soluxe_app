import 'package:flutter/material.dart';

class SlideInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset begin;
  final Offset end;
  final Curve curve;
  final int delay;
  final bool isFading;

  const SlideInWidget({
    super.key,
    required this.child,
    required this.begin,
    this.delay = 0,
    this.curve = Curves.ease,
    this.end = Offset.zero,
    this.duration = const Duration(milliseconds: 700),
  }) : isFading = false;

  const SlideInWidget.fade({
    super.key,
    required this.child,
    required this.begin,
    this.delay = 0,
    this.curve = Curves.ease,
    this.end = Offset.zero,
    this.duration = const Duration(milliseconds: 700),
  }) : isFading = true;

  @override
  State<SlideInWidget> createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<SlideInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _slideAnimation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
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
    Widget animatedChild = SlideTransition(
      position: _slideAnimation,
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
