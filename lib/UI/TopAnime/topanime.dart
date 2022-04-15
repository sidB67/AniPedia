import 'package:anipedia/UI/Widgets/animetile.dart';
import 'package:anipedia/UI/homescreen/category_heading.dart';
import 'package:anipedia/UI/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_provider.dart';

class TopAnimeScreen extends StatefulWidget {
  const TopAnimeScreen({Key? key, this.topAnime}) : super(key: key);
  final topAnime;
  @override
  State<TopAnimeScreen> createState() => _TopAnimeScreenState();
}

class _TopAnimeScreenState extends State<TopAnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 15, top: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new))),
            Container(
              margin: const EdgeInsets.only(left: 32, top: 7),
              width: 200,
              child: const Text(
                'Top Anime ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
                child: GridView.builder(
                    itemCount: widget.topAnime.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        mainAxisExtent: 310),
                    itemBuilder: (ctx, idx) {
                      return Container(
                          height: 300,
                          child: AnimeTile(animeData: widget.topAnime[idx]));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
