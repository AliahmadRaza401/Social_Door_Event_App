import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Providers/dataProvider.dart';

class HomeApi {
// Get all Tags
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
    // print(data);
    return data;
  }
}
