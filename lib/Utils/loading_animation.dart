import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

Widget loadingAnimation(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        // alignment: Alignment.center,
        child: LoadingBouncingGrid.square(
          size: MediaQuery.of(context).size.height * .04,
          backgroundColor: Color(0xff131941),
        ),
      ),
    ],
  );
}
