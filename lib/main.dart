import 'package:anipedia/UI/loadingscreen/loadingscreen.dart';
import 'package:anipedia/providers/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
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
          home: const LoadingScreen()),
    );
  }
}
