import 'package:anipedia/UI/Loader/loader.dart';
import 'package:anipedia/UI/Widgets/animetile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anime_provider.dart';
import '../homescreen/homepage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
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
      body: isLoadingScreen
          ? Loader(isLoading: isLoading)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 15, top: 30),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const HomePage())));
                        },
                        icon: const Icon(Icons.arrow_back_ios_new))),
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
                    margin:
                        const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                    child: GridView.builder(
                        controller: _scrollController,
                        itemCount: searchAnime.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 2,
                                crossAxisCount: 2,
                                mainAxisExtent: 310),
                        itemBuilder: (ctx, idx) {
                          return SizedBox(
                              height: 300,
                              child: AnimeTile(
                                animeData: searchAnime[idx],
                                isAnimate: false,
                              ));
                        }),
                  ),
                ),
                if (isLoading)
                  Container(
                    margin: const EdgeInsets.all(10),
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
    );
  }
}
