import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/header_home.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/postCard.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/tags_home.dart';
import 'package:social_door/Screens/Home/home_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeProvider _homeProvider;

  var tagsList = [];
  @override
  void initState() {
    super.initState();
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // getData(context);
  }

  // getData(BuildContext context) async {
  //   var data = await _homeProvider.getAllTags(context);
  //   print('tagsList: $data');
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              header(context),
              homeTags(context),
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: tagsList.length == null ? 0 : tagsList.length,
                      itemBuilder: (context, i) {
                        return Text(tagsList[i].title);
                      })
                ],
              ),
              PostCard(),
            ],
          ),
        ),
      ),
    );
  }
}
