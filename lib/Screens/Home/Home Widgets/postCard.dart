import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/getEvents.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Utils/loading_animation.dart';

class PostCard extends StatefulWidget {
  PostCard({Key? key}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var eventTags;
  var eventCategory;
  var events;

  @override
  void initState() {
    super.initState();
    getEvents(context);
  }

  getEvents(BuildContext context) async {
    print('Get Events Run------------------------------');

    String url = Api().getEvents;
    var token = Provider.of<DataProvider>(context, listen: false).token;
    final responce = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({"cityName": "Lahore"}),
    );

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print('data: $data');

      var getEvents = getEventFromJson(responce.body);
      setState(() {
        events = getEvents.eventsList;
      });

      print(events[0].category.categoryName);
    }
  }

  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];
  @override
  Widget build(BuildContext context) {
    return events == null
        ? loadingAnimation(context)
        : ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events == null ? 0 : events.length,
                  itemBuilder: (context, i) {
                    return eventCard(
                        events[i].title.toString(),
                        events[i].category.categoryName.toString(),
                        events[i].eventCharges.toString(),
                        Api().getEventMedia + events[i].eventThumbNail);
                  })
            ],
          );
  }

  Widget eventCard(String title, String categoreyName, String rs, url) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
        // border: Border.all(
        //   color: Color(0xffff5018),
        //   width: 1,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.255,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      // image: AssetImage("assets/png/event.jpg"),
                      image: NetworkImage(url),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text("")),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.23,
                left: 40.0,

                // right: 10.0,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 3),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "26",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "Aug",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: 40.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(Icons.party_mode),
                      _normalText(title),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.music_note),
                      _normalText(categoreyName),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      _redText("7:30"),
                      _normalText("pm / "),
                      _redText("9:00"),
                      _normalText("pm"),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      _normalText("\$"),
                      _normalText(rs),
                      _normalText(" each"),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              children: [
                                ImageStack(
                                  imageList: images,
                                  totalCount: images
                                      .length, // If larger than images.length, will show extra empty circle
                                  imageRadius: 25, // Radius of each images
                                  imageCount:
                                      3, // Maximum number of images to be shown in stack
                                  imageBorderWidth: 1,
                                  // Border width around the images
                                ),
                                _normalText("  +300 Going"),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.favorite_border_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _redText(String myText) {
    return Text(
      myText,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
    );
  }

  _normalText(String myText) {
    return Text(
      myText,
    );
  }
}
