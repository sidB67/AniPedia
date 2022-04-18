import 'package:anipedia/UI/searchscreen/searchscreen.dart';
import 'package:flutter/material.dart';

class ExpandedAppBar extends StatelessWidget {
  ExpandedAppBar({
    Key? key,
  }) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
  }

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
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                name: _controller.text,
                              )));
                },
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'Search an Anime',
                    border: InputBorder.none,
                    fillColor: const Color(0xffD0D0D0),
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                        name: _controller.text,
                                      )));
                        },
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
