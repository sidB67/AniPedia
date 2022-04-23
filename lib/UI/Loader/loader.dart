import 'package:flutter/material.dart';
import 'dart:math';

class Loader extends StatefulWidget {
  const Loader({Key? key, required this.isLoading}) : super(key: key);
  final bool isLoading;
  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angle;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));

    _angle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 360.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 360.0, end: 720.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 720.0, end: 1080.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1080.0, end: 1440.0), weight: 1),
    ]).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _angle.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.isLoading) {
          _controller.reverse();
        }
      }
      if (status == AnimationStatus.dismissed) {
        if (widget.isLoading) {
          _controller.forward();
        }
      }
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[900]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: _angle.value / 360 * 2 * pi,
              child: Image.asset(
                'asset/loadingicon.png',
                color: Colors.white,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
