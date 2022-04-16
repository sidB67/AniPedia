import 'package:anipedia/UI/Widgets/animetile.dart';
import 'package:anipedia/UI/homescreen/category_heading.dart';
import 'package:anipedia/UI/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_provider.dart';

class CurrentlyAiringScreen extends StatefulWidget {
  const CurrentlyAiringScreen({Key? key, this.maxPageRequest})
      : super(key: key);
  final maxPageRequest;
  @override
  State<CurrentlyAiringScreen> createState() => _CurrentlyAiringScreenState();
}

class _CurrentlyAiringScreenState extends State<CurrentlyAiringScreen> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int page = 2;
  void scrollListener() async {
    if (page <= widget.maxPageRequest) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        await Provider.of<AnimeProvider>(context, listen: false)
            .getCurrentAnime(page);
        setState(() {
          isLoading = false;
          page++;
        });
      }
    }
  }

  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentAnime = Provider.of<AnimeProvider>(context).currentSeason;
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
                'Currently Airing ',
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
                    controller: _scrollController,
                    itemCount: currentAnime.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            mainAxisExtent: 310),
                    itemBuilder: (ctx, idx) {
                      return Container(
                          height: 300,
                          child: AnimeTile(
                            animeData: currentAnime[idx],
                            isAnimate: false,
                          ));
                    }),
              ),
            ),
            if (isLoading)
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      'Loading',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
