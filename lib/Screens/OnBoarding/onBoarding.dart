
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';

import 'content.dart';


class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          if (currentIndex == contents.length - 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Login(),
              ),
            );
          }
        },
        child: Container(
          color: Color(0xff1A1A36),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                            builder: (_) => Login()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 17, top: 24),
                        padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                        alignment:Alignment.center,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffA8A8A8)
                        ),
                        child: Text("Skip"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image,
                              height: 300,
                              fit: BoxFit.contain,
                              // color: Colors.white,
                              // allowDrawingOutsideViewBox: true,
                            ),
                            Text(
                              contents[i].title,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              contents[i].discription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                          (index) => buildDot(index, context),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                // Container(
                //   height: 60,
                //   margin: EdgeInsets.all(40),
                //   width: double.infinity,
                //   child: FlatButton(
                //     child: Text(
                //         currentIndex == contents.length - 1 ? "Continue" : "Next"),
                //     onPressed: () {
                //       if (currentIndex == contents.length - 1) {
                //         Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //             builder: (_) => Home(),
                //           ),
                //         );
                //       }
                //       _controller.nextPage(
                //         duration: Duration(milliseconds: 100),
                //         curve: Curves.bounceIn,
                //       );
                //     },
                //     color: Theme.of(context).primaryColor,
                //     textColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    );
  }
}