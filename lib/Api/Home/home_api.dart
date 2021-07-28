import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Api/api.dart';

class HomeApi {
// Get all Tags
   getAllTags() async {
    print("------------ Get All Tags");
    final responce = await http.post(
      Uri.parse(Api().getAllTags),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MGM4NDE4ZDIyOGI3YjAwMjI1OGE0ZWEiLCJpYXQiOjE2Mjc0OTY4MjYsImV4cCI6MTYyNzU4MzIyNn0.ZkAcHDBmoD7agMq01kV8uhz_R-2hi6flcrN3tjhXgFg'
      },
    );
    final data = jsonDecode(responce.body);
    print(data);
    return data;
  }
}
