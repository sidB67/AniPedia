import 'package:flutter/material.dart';
import '../../models/anime.dart';
import '../sizeconfig.dart';

class AnimeTile extends StatelessWidget {
  const AnimeTile({Key? key, required this.animeData}) : super(key: key);
  final Anime animeData;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, blurRadius: 2, offset: Offset(3.0, 4.0)),
          ]),
      width: 180,
      height: SizeConfig.safeBlockVertical * 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //For image of the anime
          Container(
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
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            width: 200,
            child: RichText(
              text: TextSpan(
                text: 'Rank : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: '${animeData.rank}',
                    style: TextStyle(
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
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: '${animeData.score}/10',
                    style: TextStyle(
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
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: animeData.status,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
