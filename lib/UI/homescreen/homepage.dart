import 'package:anipedia/providers/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/animetile.dart';
import '../Widgets/loadmorebutton.dart';
import 'category_heading.dart';
import 'extended_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topAnime =
        Provider.of<AnimeProvider>(context, listen: false).topAnime;
    final currentAnime =
        Provider.of<AnimeProvider>(context, listen: false).currentSeason;
    return Scaffold(
      backgroundColor: const Color(0xffF3F1F5),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
              pinned: true,
              centerTitle: true,
              title: Text('AniPedia'),
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
                          )
                        : LoadMoreButton(
                            onPressed: () {},
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
                          )
                        : LoadMoreButton(
                            onPressed: () {},
                          );
                  }),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20))
        ],
      ),
    );
  }
}
