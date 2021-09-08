import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';

class PostEventApi {
  // static Future<List<CreateEvent>> createEvent(BuildContext context) async {
  //   print('createEvent: Run------------------------------');

  //   String url = Api().createEvent;
  //   var token = Provider.of<DataProvider>(context, listen: false).token;
  //   final responce = await http.post(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': token,
  //   });

  //   final CreateEvent create = welcomeFromJson(responce.body);

  //   // var data = jsonDecode(responce.body);
  //   // // print('CreationData: ${data['eventCreationData']}');

  //   // final List<CreateEvent> createvent =
  //   //     welcomeFromJson(data) as List<CreateEvent>;
  //   // // final welcome = welcomeFromJson(data);

  //   return create;
  // }

  Future createEvent(BuildContext context) async {
    print('createEvent: Run------------------------------');

    String url = Api().createEvent;
    var token = Provider.of<DataProvider>(context, listen: false).token;
    final responce = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      var createEventData = welcomeFromJson(responce.body);
      // var rule = create.eventCreationData.eventRulesList;
      // debugPrint(rule[0].title);
      return createEventData;
    } else
      return responce.statusCode.toString();
  }
}
