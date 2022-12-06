import 'package:flutter/material.dart';

class Responsiveness extends StatelessWidget {
  const Responsiveness({
    Key? key,
    required this.largeScreen,
    required this.smallScreen,
  }) : super(key: key);

  final Widget largeScreen;
  final Widget smallScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return largeScreen;
          } else {
            return smallScreen;
          }
        },
      ),
    );
  }
}
