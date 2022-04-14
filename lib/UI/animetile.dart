import 'package:flutter/material.dart';

class AnimeTile extends StatelessWidget {
  const AnimeTile({Key? key, this.idx}) : super(key: key);
  final idx;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, blurRadius: 2, offset: Offset(3.0, 4.0)),
          ]),
      width: 220,
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
                'https://cdn.myanimelist.net/images/anime/1493/116732l.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          //For title of anime
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            width: 200,
            child: Text(
              '${idx + 1}. Naruto Shippuden',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 12),
            width: 200,
            child: RichText(
              text: const TextSpan(
                text: 'Score : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: '9/10',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            width: 200,
            child: RichText(
              text: const TextSpan(
                text: 'Status : ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: 'Finished Airing',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
