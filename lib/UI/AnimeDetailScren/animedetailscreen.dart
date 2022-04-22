import 'package:anipedia/models/anime.dart';
import 'package:flutter/material.dart';

import '../homescreen/homepage.dart';

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({Key? key, required this.anime}) : super(key: key);
  final Anime anime;
  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  String capitalise(String season) {
    return season[0].toUpperCase() + season.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 5,
                  bottom: 7,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[900]!,
                      Colors.blue[400]!,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.network(
                            widget.anime.image_url,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(children: [
                                  Text(
                                    widget.anime.title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ]),
                                const SizedBox(
                                  height: 18,
                                ),
                                HeadinSubHeading(
                                  heading: 'Rank',
                                  subheading: '${widget.anime.rank}',
                                ),
                                HeadinSubHeading(
                                  heading: 'Score',
                                  subheading: '${widget.anime.score}/10',
                                ),
                                HeadinSubHeading(
                                  heading: 'Episodes',
                                  subheading: widget.anime.no_of_episodes,
                                ),
                                HeadinSubHeading(
                                  heading: 'Status',
                                  subheading: widget.anime.status,
                                ),
                                HeadinSubHeading(
                                  heading: 'Aired',
                                  subheading:
                                      '${capitalise(widget.anime.season)} ${widget.anime.year}',
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 12, right: 12),
              child: const Text(
                'Synopsis :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
              child: Text(
                widget.anime.synopsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeadinSubHeading extends StatelessWidget {
  const HeadinSubHeading(
      {Key? key, required this.heading, required this.subheading})
      : super(key: key);

  final String heading;
  final subheading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$heading : ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: '$subheading',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
