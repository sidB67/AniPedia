import 'dart:async';

import 'package:flutter/material.dart';

class LoadMoreButton extends StatefulWidget {
  const LoadMoreButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  State<LoadMoreButton> createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                color = Colors.blue;
              });
              Timer(const Duration(milliseconds: 50), widget.onPressed);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        spreadRadius: .8,
                        offset: Offset(3.0, 4.0)),
                  ]),
              child: const Icon(Icons.arrow_right_alt_sharp),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Load More',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
