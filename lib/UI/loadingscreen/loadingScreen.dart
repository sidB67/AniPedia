import 'package:anipedia/UI/homescreen/homepage.dart';
import 'package:anipedia/providers/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initialiseState();
  }

  @override
  void dispose() {
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
