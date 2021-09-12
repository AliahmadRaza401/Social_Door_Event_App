import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

Widget loadingAnimation(BuildContext context) {
  return Container(
    // alignment: Alignment.center,
    height: MediaQuery.of(context).size.height,
    child: LoadingBouncingGrid.square(
      size: MediaQuery.of(context).size.height * .04,
      backgroundColor: Color(0xff131941),
    ),
  );
}
