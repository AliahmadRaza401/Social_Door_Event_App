import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/getEvents.dart';
import 'package:social_door/Model/home_tags_model.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';

class HomeProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  var tagsList = [];

  Future getAllTags(BuildContext context) async {
    print("------------ Get All Tags");
    var token = Provider.of<DataProvider>(context).token;
    print('token: $token');
    final responce = await http.post(
      Uri.parse(Api().getAllTags),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    final data = jsonDecode(responce.body);
    print(data);
    return data;
  }
}
