import 'package:anipedia/UI/Widgets/animetile.dart';
import 'package:anipedia/UI/homescreen/category_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.name}) : super(key: key);

  final name;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController = ScrollController();
  bool isLoadingScreen = false;
  bool isLoading = false;
  int page = 2;
  int maxPage = 2;
  void scrollListener() async {
    if (page <= maxPage) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        await Provider.of<AnimeProvider>(context, listen: false)
            .getSearchAnime(widget.name, page);
        setState(() {
          isLoading = false;
          page++;
        });
      }
    }
  }

  void initialise() async {
    setState(() {
      isLoadingScreen = true;
    });

    await Provider.of<AnimeProvider>(context, listen: false)
        .getSearchAnime(widget.name, 1);

    setState(() {
      isLoadingScreen = false;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    initialise();
    maxPage = Provider.of<AnimeProvider>(context, listen: false).searchPages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchAnime =
        Provider.of<AnimeProvider>(context, listen: false).searchAnime;
    return Scaffold(
      body: SafeArea(
        child: isLoadingScreen
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                    child: Text(
                      'Search Results for ${widget.name} (${searchAnime.length})',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, top: 20, bottom: 10),
                      child: GridView.builder(
                          controller: _scrollController,
                          itemCount: searchAnime.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 2,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.68),
                          itemBuilder: (ctx, idx) {
                            return Container(
                                height: 300,
                                child: AnimeTile(animeData: searchAnime[idx]));
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
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
