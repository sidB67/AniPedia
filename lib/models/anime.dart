// ignore_for_file: non_constant_identifier_names

class Anime {
  final int mal_id;
  final String image_url;
  List images = [];
  final String title;
  final int no_of_episodes;
  final String status;
  final num score;
  final int rank;
  final String synopsis;
  final String season;
  final int year;

  Anime(
      {required this.mal_id,
      required this.image_url,
      required this.title,
      required this.no_of_episodes,
      required this.status,
      required this.score,
      required this.rank,
      required this.synopsis,
      required this.season,
      required this.year});
}
