import 'package:flutter/material.dart';

Widget header(BuildContext context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * .1,
    padding: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        color: Color(0xff131941),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
    child: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lahore",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "26 August - 28 August   |",
                        style: TextStyle(color: Color(0xffF5F5F5)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.tune_outlined,
                        color: Colors.white,
                        size: 25,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 25,
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
