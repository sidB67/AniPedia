import 'package:flutter/material.dart';

import 'category_heading.dart';
import 'extended_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.only(left: 20, top: 20),
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, idx) {
                    return Container(
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      width: 220,
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
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      width: 220,
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
