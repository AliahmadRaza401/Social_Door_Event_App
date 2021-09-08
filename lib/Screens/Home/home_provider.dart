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

  // Future getAllTags() async {
  //   try {
  //     print("---------Get All Tags-------------------");
  //     // var token = Provider.of<DataProvider>(context).token;
  //     // print('token: $token');
  //     final responce = await http.get(
  //       Uri.parse(Api().getAllTags),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTA1MzkxNzc5MGY1MjAwMjI3ZWI4MjAiLCJpYXQiOjE2MzA5MjQ2NTEsImV4cCI6MTYzMTAxMTA1MX0.ssiwY09TQfBEmHFjiuHDNutyM5zUujckTHFJBtEvxV8',
  //       },
  //     );
  //     final result = jsonDecode(responce.body);
  //     if (result['status'] == 200) {
  //       var data = result['data'];
  //       print('Tags data: $data');
  //       // tagsList.clear();
  //       // for (var i in data) {
  //       //   HomeTagsModel data = HomeTagsModel(
  //       //     id: i['_id'],
  //       //     title: i['tag_name'],
  //       //   );
  //       //   tagsList.add(data);
  //       // }
  //       // print('boardListData: $boardListData');
  //       return tagsList;
  //     } else {
  //       return "No Result";
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}
