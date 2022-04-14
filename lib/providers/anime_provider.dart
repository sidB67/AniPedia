import 'dart:convert';

import 'package:anipedia/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimeProvider with ChangeNotifier {
  List<Anime> _currentSeason = [];

  List<Anime> _topAnime = [];

  List<Anime> _searchAnime = [];

  int curreSeasonPages = 1;
  int searchPages = 1;
  List<Anime> get currentSeason {
    return [..._currentSeason];
  }

  List<Anime> get topAnime {
    return [..._topAnime];
  }

  List<Anime> get searchAnime {
    return [..._searchAnime];
  }

  Future<void> getTopAnime() async {
    _topAnime = [];
    final url = Uri.parse('https://api.jikan.moe/v4/top/anime');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final extractedData = responseData["data"] as List;
    extractedData.forEach((animeData) {
      _topAnime.add(Anime(
          mal_id: animeData["mal_id"],
          image_url: animeData["images"]["jpg"]["large_image_url"],
          title: animeData["title"],
          no_of_episodes: animeData["episodes"] ?? 0,
          status: animeData["status"],
          score: animeData["score"],
          rank: animeData["rank"],
          synopsis: animeData["synopsis"] ?? '',
          season: animeData["season"] ?? '',
          year: animeData["year"] ?? 0));
    });

    notifyListeners();
  }

  Future<void> getCurrentAnime(int page) async {
    if (page == 1) {
      _currentSeason = [];
    }
    final url = Uri.parse('https://api.jikan.moe/v4/seasons/now?page=$page');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    if (page == 1) {
      curreSeasonPages = responseData["pagination"]["last_visible_page"];
      print(curreSeasonPages);
    }
    final extractedData = responseData["data"] as List;
    extractedData.forEach((animeData) {
      _currentSeason.add(Anime(
          mal_id: animeData["mal_id"],
          image_url: animeData["images"]["jpg"]["large_image_url"],
          title: animeData["title"],
          no_of_episodes: animeData["episodes"] ?? 0,
          status: animeData["status"],
          score: animeData["score"] ?? 0,
          rank: animeData["rank"] ?? 0,
          synopsis: animeData["synopsis"] ?? '',
          season: animeData["season"] ?? '',
          year: animeData["year"] ?? 0));
    });
    print(_currentSeason.length);

    notifyListeners();
  }

  Future<void> getSearhAnime(String name, int page) async {
    if (page == 1) {
      _searchAnime = [];
    }
    final url = Uri.parse('https://api.jikan.moe/v4/anime?q=$name&page=$page');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    if (page == 1) {
      searchPages = responseData["pagination"]["last_visible_page"];
      print(curreSeasonPages);
    }
    final extractedData = responseData["data"] as List;
    extractedData.forEach((animeData) {
      _searchAnime.add(Anime(
          mal_id: animeData["mal_id"],
          image_url: animeData["images"]["jpg"]["large_image_url"],
          title: animeData["title"],
          no_of_episodes: animeData["episodes"] ?? 0,
          status: animeData["status"],
          score: animeData["score"] ?? 0,
          rank: animeData["rank"] ?? 0,
          synopsis: animeData["synopsis"] ?? '',
          season: animeData["season"] ?? '',
          year: animeData["year"] ?? 0));
    });
    print(_searchAnime.length);

    notifyListeners();
  }
}
