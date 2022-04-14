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
                      margin: EdgeInsets.only(right: 20, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                                offset: Offset(3.0, 4.0)),
                          ]),
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //For image of the anime
                          Container(
                            width: double.infinity,
                            height: 180,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.network(
                                'https://cdn.myanimelist.net/images/anime/1493/116732l.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          //For title of anime
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 7),
                            width: 200,
                            child: Text(
                              '${idx + 1}. Naruto Shippuden',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
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
