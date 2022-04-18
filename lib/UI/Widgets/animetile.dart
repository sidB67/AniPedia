import 'dart:async';

import 'package:flutter/material.dart';
import '../../models/anime.dart';
import '../sizeconfig.dart';

class AnimeTile extends StatefulWidget {
  const AnimeTile({Key? key, required this.animeData, required this.isAnimate})
      : super(key: key);
  final Anime animeData;
  final bool isAnimate;

  @override
  State<AnimeTile> createState() => _AnimeTileState();
}

class _AnimeTileState extends State<AnimeTile>
    with SingleTickerProviderStateMixin {
  double _margin = 20;
  double _opacity = 0;
  late AnimationController _animationController;
  late Animation<Offset> _position;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.addListener(() {});

    _position =
        Tween<Offset>(begin: const Offset(0.5, 0), end: const Offset(0, 0))
            .animate(_animationController);

    _animationController.forward();
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _margin = 0;
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return widget.isAnimate
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: EdgeInsets.only(left: _margin, right: 20, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(3.0, 4.0)),
                ]),
            width: 180,
            height: SizeConfig.safeBlockVertical * 300,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 900),
              opacity: _opacity,
              child: AnimeTileContent(animeData: widget.animeData),
            ),
          )
        : SlideTransition(
            position: _position,
            child: Container(
              margin: const EdgeInsets.only(right: 20, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(3.0, 4.0)),
                  ]),
              width: 180,
              height: SizeConfig.safeBlockVertical * 300,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 900),
                opacity: _opacity,
                child: AnimeTileContent(animeData: widget.animeData),
              ),
            ),
          );
  }
}

class AnimeTileContent extends StatelessWidget {
  const AnimeTileContent({
    Key? key,
    required this.animeData,
  }) : super(key: key);

  final Anime animeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //For image of the anime
        SizedBox(
          width: double.infinity,
          height: 180,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Image.network(
              animeData.image_url,
              fit: BoxFit.fill,
            ),
          ),
        ),
        //For title of anime
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          width: SizeConfig.safeBlockHorizontal * 200,
          child: Text(
            animeData.title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          width: 200,
          child: RichText(
            text: TextSpan(
              text: 'Rank : ',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: '${animeData.rank}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 2),
          width: 200,
          child: RichText(
            text: TextSpan(
              text: 'Score : ',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: '${animeData.score}/10',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 2),
          width: 200,
          child: RichText(
            text: TextSpan(
              text: 'Status : ',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: animeData.status,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
