import 'package:anipedia/UI/loadingscreen/loadingScreen.dart';
import 'package:anipedia/providers/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/homescreen/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AnimeProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const LoadingScreen(),
      ),
    );
  }
}
