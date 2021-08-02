import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/api.dart';

class HomeApi {
  //get Brearear Token
  // getBToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

// Get all Tags
  getAllTags() async {
    print("------------ Get All Tags");
    SharedPreferences prefs =
        SharedPreferences.getInstance() as SharedPreferences;
    var token;
    token = prefs.getString('token');
    debugPrint("Your Token is : ${token.toString()}");
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
