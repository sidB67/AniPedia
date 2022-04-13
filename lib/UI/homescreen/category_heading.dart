import 'package:flutter/material.dart';

class CategoryHeading extends StatelessWidget {
  const CategoryHeading({Key? key, required this.heading}) : super(key: key);
  final String heading;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      margin: const EdgeInsets.only(left: 32, top: 25),
      width: 120,
      child: Text(
        heading,
        style: const TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
      ),
    ));
  }
}
