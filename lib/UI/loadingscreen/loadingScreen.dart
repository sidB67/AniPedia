import 'dart:async';

import 'package:anipedia/UI/homescreen/homepage.dart';
import 'package:anipedia/providers/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  late Animation<double> _sizeAnimation;
  late AnimationController _animationController;
  late Animation<Offset> _position;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animationController.addListener((() {}));
    _sizeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _position =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(_animationController);
    _animationController.forward();
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _opacity = 1;
      });
    });
    initialiseState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void initialiseState() async {
    try {
      await Provider.of<AnimeProvider>(context, listen: false).getTopAnime();
      await Provider.of<AnimeProvider>(context, listen: false)
          .getCurrentAnime(1);
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Unable to Load Animes at this moment'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          });
    } finally {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const HomePage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: SlideTransition(
            position: _position,
            child: ScaleTransition(
              scale: _sizeAnimation,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                opacity: _opacity,
                child: const Text(
                  'AniPedia',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
