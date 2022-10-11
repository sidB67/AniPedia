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
        vsync: this, duration: const Duration(milliseconds: 1800));

    _angle = Tween<double>(begin: -2 * pi, end: 2 * pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    // _angle.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     if (widget.isLoading) {
    //       _controller.repeat();
    //     }
    //   }
    // });
    _controller.forward();
    _controller.repeat();
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
              angle: _angle.value,
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
