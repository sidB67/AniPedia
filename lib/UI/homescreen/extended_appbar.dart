import 'package:flutter/material.dart';

class ExpandedAppBar extends StatelessWidget {
  const ExpandedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
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
      child: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomCenter,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search an Anime',
                    border: InputBorder.none,
                    fillColor: Color(0xffD0D0D0),
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ))),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
