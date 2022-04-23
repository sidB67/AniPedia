// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:anipedia/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimeProvider with ChangeNotifier {
  List<Anime> _currentSeason = [];

  List<Anime> _topAnime = [];

  List<Anime> _searchAnime = [];

  List<Anime> _recommendationList = [];

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

  List<Anime> get recommendationAnime {
    return [..._recommendationList];
  }

  Future<void> getTopAnime() async {
    _topAnime = [];
    final url = Uri.parse('https://api.jikan.moe/v4/top/anime?page=1');
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

    notifyListeners();
  }

  Future<void> getSearchAnime(String name, int page) async {
    if (page == 1) {
      _searchAnime = [];
    }
    final url = Uri.parse('https://api.jikan.moe/v4/anime?q=$name&page=$page');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    if (page == 1) {
      searchPages = responseData["pagination"]["last_visible_page"];
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

    notifyListeners();
  }

  // Future<void> getAnimePictures(List<Anime> anime) async {
  //   anime.forEach((element) async {
  //     final url = Uri.parse(
  //         'https://api.jikan.moe/v4/anime/${element.mal_id}/pictures');
  //     final response = await http.get(url);
  //     final responseData = jsonDecode(response.body);
  //     final extractedData = responseData["data"] as List;
  //     extractedData.forEach((imgData) {
  //       element.images.add(imgData["images"]["jpg"]["large_image_url"]);
  //     });
  //   });

  //   print(anime[0].images);
  // }
  Future<void> animeRecommendations(int mal_id) async {
    List mal_ids = [];
    _recommendationList = [];
    final url =
        Uri.parse('https://api.jikan.moe/v4/anime/$mal_id/recommendations');

    final response = await http.get(url);
    final responseData = json.decode(response.body);

    final extractedData = responseData["data"] as List;
    extractedData.forEach((element) {
      final elementData = element["entry"];

      mal_ids.add(elementData["mal_id"]);
    });
    for (int i = 0; i < 4; i++) {
      final url2 = Uri.parse('https://api.jikan.moe/v4/anime/${mal_ids[i]}');
      final response2 = await http.get(url2);
      final responseData2 = json.decode(response2.body);
      print(url2);
      try {
        final animeData = responseData2["data"];

        _recommendationList.add(Anime(
            mal_id: mal_ids[i],
            image_url: animeData["images"]["jpg"]["large_image_url"],
            title: animeData["title"],
            no_of_episodes: animeData["episodes"] ?? 0,
            status: animeData["status"],
            score: animeData["score"] ?? 0,
            rank: animeData["rank"] ?? 0,
            synopsis: animeData["synopsis"] ?? '',
            season: animeData["season"] ?? '',
            year: animeData["year"] ?? 0));
      } catch (e) {
        print(responseData2);
        print(mal_ids[i]);
        print(e);
      }
    }
  }
}
