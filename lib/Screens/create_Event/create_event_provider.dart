import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:social_door/common_widget/commom_widget.dart';
import 'package:flutter/services.dart';

class CreateEventProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  String deviceName = '';
  String deviceVersion = '';
  String deviceID = '';

  var selectedAmentites = [];
  var selectedPrefrences = [];
  var selectedRule = [];
  var selectedCencelPolicy = [];
  var title;
  var categorey;
  var titleController;
  var volNumber;
  var host;
  var userIns;
  var eventcharges;
  var date;
  var startTime;
  var endTime;
  var type;
  var home;
  var street;
  var floor;
  var city;
  var postelCode;
  var email;
  var phone;
  var description;
  var cordinates;
  var paymentInfo;
  var imagefile;

  Future<void> addEvent(BuildContext context) async {
    try {
      print(" ---------Ad Event------------------");
      print('email: $email');
      var token = Provider.of<DataProvider>(context, listen: false).token;
      print('token: $token');

      http.Response _response = await http.post(
        Uri.parse(Api().addEvent),
        headers: {
          'content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'eventThumbNail': imagefile,
          'data': {
            'title': title,
            'category': categorey,
            'hostedDate': date,
            'startTime': startTime,
            'endTime': endTime,
            'eventPhone': phone,
            'eventEmailAddress': email,
            'eventCharges': eventcharges,
            'host': deviceID,
            'volume': volNumber,
            'rules': selectedRule,
            'prefrences': selectedPrefrences,
            'amenities': selectedAmentites,
            'userInstructions': userIns,
            'cancellationPolicy': selectedCencelPolicy,
            'venue': {
              'type': type,
              'home': home,
              'street': street,
              'floor': floor,
              'city': city,
              'postal_code': postelCode,
              'coordinates': cordinates,
            },
            'description': description,
            'paypalToken': paymentInfo,
          },
        }),
        //  jsonEncode({
        //   'eventThumbNail': imagefile,
        //   'data': {
        //     'title': title,
        //     'category': categorey,
        //     'hostedDate': "2020-09-18",
        //     'startTime': "2020-09-18",
        //     'endTime': "2020-09-18",
        //     'eventPhone': "+923069601630",
        //     'eventEmailAddress': email,
        //     'eventCharges': eventcharges,
        //     'host': deviceID,
        //     'volume': volNumber,
        //     'rules': selectedRule,
        //     'prefrences': selectedPrefrences,
        //     'amenities': selectedAmentites,
        //     'userInstructions': userIns,
        //     'cancellationPolicy': selectedCencelPolicy,
        //     'venue': {
        //       'type': type,
        //       'home': home,
        //       'street': street,
        //       'floor': floor,
        //       'city': city,
        //       'postal_code': postelCode,
        //       'coordinates': cordinates,
        //     },
        //     'description': description,
        //     'paypalToken': "654dgd65454ggd",
        //   },
        // }),
      );
      print('Add Event _response------------ : $_response');
      var result = jsonDecode(_response.body);
      print('result-------: $result');

      if (_response.statusCode == 200) {
        print("Add event APi Success!");

        print(_response.body);

        CommomWidget().showAlertDialog(context, "EventCreate Successfully");
      } else {
        print("Responce Fail");
        CommomWidget().showAlertDialog(context, "Something Wrong");
      }
    } catch (e) {
      return CommomWidget().showAlertDialog(context, e.toString());
    }
  }

  Future<void> deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        deviceID = build.androidId;

        // setState(() {
        //   deviceName = build.model;
        //   deviceVersion = build.version.toString();
        //   identifier = build.androidId;
        // });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        deviceID = data.identifierForVendor;
        // setState(() {
        //   deviceName = data.name;
        //   deviceVersion = data.systemVersion;
        //   identifier = data.identifierForVendor;
        // });//UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  // createEvent(BuildContext context) async {
  //   print('createEvent: Run------------------------------');

  //   String url = Api().createEvent;
  //   var token = Provider.of<DataProvider>(context, listen: false).token;
  //   final responce = await http.post(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': token,
  //   });

  //   if (responce.statusCode == 200) {
  //     var data = jsonDecode(responce.body);
  //     createEventData = welcomeFromJson(responce.body);
  //     return createEventData;
  //   }
  // }

}
