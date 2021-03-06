import 'package:anipedia/UI/CurrentlyAiring/currentlyairingscreen.dart';
import 'package:anipedia/UI/TopAnime/topanime.dart';
import 'package:anipedia/providers/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/animetile.dart';
import '../Widgets/loadmorebutton.dart';
import '../sizeconfig.dart';
import 'category_heading.dart';
import 'extended_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final topAnime = Provider.of<AnimeProvider>(context).topAnime;
    final currentAnime = Provider.of<AnimeProvider>(context).currentSeason;
    final currentSeasonPages =
        Provider.of<AnimeProvider>(context).curreSeasonPages;
    return Scaffold(
      backgroundColor: const Color(0xffF3F1F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              centerTitle: true,
              title: const Text('AniPedia'),
              expandedHeight: 125,
              flexibleSpace: ExpandedAppBar()),
          const CategoryHeading(
            heading: 'Top Anime',
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, idx) {
                    return idx < 5
                        ? AnimeTile(
                            animeData: topAnime[idx],
                            isAnimate: true,
                          )
                        : LoadMoreButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopAnimeScreen(
                                            topAnime: topAnime,
                                          )));
                            },
                          );
                  }),
            ),
          ),
          const CategoryHeading(
            heading: 'Current Season',
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, idx) {
                    return idx < 5
                        ? AnimeTile(
                            animeData: currentAnime[idx],
                            isAnimate: true,
                          )
                        : LoadMoreButton(onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurrentlyAiringScreen(
                                          maxPageRequest: currentSeasonPages,
                                        )));
                          });
                  }),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20))
        ],
      ),
    );
  }
}
