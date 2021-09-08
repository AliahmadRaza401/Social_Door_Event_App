import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';

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

  var latitude;
  var longitude;
  var paymentId;

  var payerId;

  var paypalToken;

  var imagefile;
//  'https://4cfa-154-192-195-15.ngrok.io/api/user/events/addEvent'
  // var uri = Uri.parse(
  //       'https://4cfa-154-192-195-15.ngrok.io/api/user/events/addEvent');
  //   var request = http.MultipartRequest('POST', uri)
  //     ..fields['user'] = 'nweiz@google.com'
  //     ..files.add(await http.MultipartFile.fromPath(
  //         'eventThumbNail', imagefile.path,
  //         contentType: MediaType('application', 'x-tar')));
  //   var response = await request.send();
  //   if (response.statusCode == 200) print('Uploaded!');

  var rule = ["610e54a2dba82c1c9e84f171"];

  Future<void> addEvent(BuildContext context) async {
    print('startTime: $startTime');
    print('endTime: $endTime');
    print('paymentId: $paymentId');
    print('payerId: $payerId');
    print('paypalToken: $paypalToken');
    print('longitude: $longitude');
    print('latitude: $latitude');
    // var data = {
    //   "title": "Tornonto New Year Party",
    //   "category": "611209da00179061507ab19d",
    //   "hostedDate": "2021-09-18",
    //   "startTime": "2021-09-18",
    //   "endTime": "2020-09-18",
    //   "eventPhone": "+923069601630",
    //   "eventEmailAddress": "fahad@gmail.com",
    //   "eventCharges": 10,
    //   "host": "60c8418d228b7b002258a4ea",
    //   "volume": 100,
    //   "rules": ["610e54a2dba82c1c9e84f171"],
    //   "prefrences": ["610e53a17222e01ba915818d"],
    //   "amenities": ["6112082700179061507ab199"],
    //   "userInstructions": "User have to take drinks,umbrellas",
    //   "cancellationPolicy": ["6112094900179061507ab19a"],
    //   "venue": {
    //     "type": "event",
    //     "home": "123",
    //     "street": "walkaway street",
    //     "floor": 2,
    //     "city": "Tornonto",
    //     "postal_code": 54920,
    //     "coordinates": 12
    //   },
    //   "description": "this is description",
    //   "paypalToken": "654dgd65454ggd"
    // };

    var data = {
      'title': title,
      'category': "611209da00179061507ab19d",
      'hostedDate': date,
      'startTime': startTime,
      'endTime': endTime,
      'eventPhone': phone,
      'eventEmailAddress': email,
      'eventCharges': eventcharges,
      'host': '61053917790f5200227eb820',
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
        'longitude': longitude,
        'latitude': latitude
      },
      'description': description,
      'paypalToken': paypalToken,
      'payerId': payerId,
      'paymentId': paymentId
    };
    // var data = {
    //   "title": title,
    //   "category": "611209da00179061507ab19d",
    //   "hostedDate": "2021-09-18",
    //   "startTime": "2021-09-18",
    //   "endTime": "2020-09-18",
    //   "eventPhone": "+923069601630",
    //   "eventEmailAddress": "fahad@gmail.com",
    //   "eventCharges": 10,
    //   "host": "60c8418d228b7b002258a4ea",
    //   "volume": 100,
    //   "rules": ["610e53a17222e01ba915818d"],
    //   "prefrences": ["610e53a17222e01ba915818d"],
    //   "amenities": ["610e53a17222e01ba915818d"],
    //   "userInstructions": "User have to take drinks,umbrellas",
    //   "cancellationPolicy": ["610e53a17222e01ba915818d"],
    //   "venue": {
    //     "type": "event",
    //     "home": "123",
    //     "street": "event",
    //     "floor": "3",
    //     "city": "event",
    //     "postal_code": "123",
    //     "coordinates": 12
    //   },
    //   "description": "this is description",
    //   "paypalToken": "654dgd65454ggd"
    // };
    var token = Provider.of<DataProvider>(context, listen: false).token;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          // Api().addEvent
          'https://53e6-103-57-171-121.ngrok.io/api/user/events/addEvent'),
    );
    Map<String, String> headers = {
      "Authorization": token,
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'eventThumbNail',
        imagefile.readAsBytes().asStream(),
        imagefile.lengthSync(),
        filename: "eventThumbNail",
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);

    request.fields.addAll({'data': jsonEncode(data)});
    var res = await request.send();
    print("This is response:" + res.reasonPhrase.toString());
    return null;
  }

  // Future<void> addEvent(BuildContext context) async {
  //   try {
  //     print(" ---------Ad Event------------------");

  //     var token = Provider.of<DataProvider>(context, listen: false).token;
  //     print('token: $token');
  //     print("Image File:  ${imagefile.path}");

  //     http.Response _response = await http.post(Uri.parse(
  //             // Api().addEvent
  //             'https://4cfa-154-192-195-15.ngrok.io/api/user/events/addEvent'),
  //         headers: {
  //           'content-Type': 'application/json',
  //           'Authorization': token,
  //         },
  //         body: jsonEncode({
  //           'eventThumbNail': "",
  //           'data': {
  //             "title": "Tornonto New Year Party",
  //             "category": "611209da00179061507ab19d",
  //             "hostedDate": "2021-09-18",
  //             "startTime": "2021-09-18",
  //             "endTime": "2020-09-18",
  //             "eventPhone": "+923069601630",
  //             "eventEmailAddress": "fahad@gmail.com",
  //             "eventCharges": 10,
  //             "host": "60c8418d228b7b002258a4ea",
  //             "volume": 100,
  //             "rules": ["610e54a2dba82c1c9e84f171"],
  //             "prefrences": ["610e53a17222e01ba915818d"],
  //             "amenities": ["6112082700179061507ab199"],
  //             "userInstructions": "User have to take drinks,umbrellas",
  //             "cancellationPolicy": ["6112094900179061507ab19a"],
  //             "venue": {
  //               "type": "event",
  //               "home": "123",
  //               "street": "walkaway street",
  //               "floor": 2,
  //               "city": "Tornonto",
  //               "postal_code": 54920,
  //               "coordinates": 12
  //             },
  //             "description": "this is description",
  //             "paypalToken": "654dgd65454ggd"
  //           }
  //         }));
  //     print('Add Event _response------------ : $_response');
  //     var result = jsonDecode(_response.body);
  //     print('result-------: $result');

  //     if (_response.statusCode == 200) {
  //       print("Add event APi Success!");

  //       print(_response.body);

  //       CommomWidget().showAlertDialog(context, "EventCreate Successfully");
  //     } else {
  //       print("Responce Fail");
  //       print("Status code: ${_response.statusCode}");
  //       CommomWidget().showAlertDialog(context, "Something Wrong");
  //     }
  //   } catch (e) {
  //     return CommomWidget().showAlertDialog(context, e.toString());
  //   }
  // }

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
}


   // 'title': title,
              // 'category': categorey,
              // 'hostedDate': date,
              // 'startTime': "2021-09-18",
              // 'endTime': "2021-09-18",
              // 'eventPhone': phone,
              // 'eventEmailAddress': email,
              // 'eventCharges': eventcharges,
              // 'host': "60c8418d228b7b002258a4ea",
              // 'volume': volNumber,
              // 'rules': "610e54a2dba82c1c9e84f171",
              // 'prefrences': selectedPrefrences,
              // 'amenities': selectedAmentites,
              // 'userInstructions': userIns,
              // 'cancellationPolicy': selectedCencelPolicy,
              // 'venue': {
              //   'type': type,
              //   'home': home,
              //   'street': street,
              //   'floor': floor,
              //   'city': city,
              //   'postal_code': postelCode,
              //   'coordinates': 123,
              // },
              // 'description': description,
              // 'paypalToken': "sjdflkasd",