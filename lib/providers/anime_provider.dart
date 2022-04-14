import 'package:anipedia/models/anime.dart';
import 'package:flutter/material.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _currentSeason = [];

  List<Anime> _topAnime = [];

  List<Anime> _searchAnime = [];

  List<Anime> get currentSeason {
    return [..._currentSeason];
  }

  List<Anime> get topAnime {
    return [..._topAnime];
  }

  List<Anime> get searchAnime {
    return [..._searchAnime];
  }

  Future<void> getTopAnime() async {}

  Future<void> getCurrentAnime() async {}

  Future<void> getSearhAnime(String name, int page) async {}
}
