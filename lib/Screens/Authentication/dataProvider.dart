import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Api/api.dart';

class DataProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  var token;
  var authenticationID;

  Future authticate() async {
    try {
      print("----------- authticate user ---------------");

      final _responce = await http.get(
        Uri.parse(Api().authenticate),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );

      var result = jsonDecode(_responce.body);
      print('authticate user : $result');
      authenticationID = result['_id'];
      print('authenticationID*****************************: $authenticationID');
    } catch (e) {}
  }
}
