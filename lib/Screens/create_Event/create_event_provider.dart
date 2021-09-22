import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/getEvents.dart';
import 'package:social_door/Model/hosted_event_model.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';
import 'package:social_door/Screens/Home/home.dart';
import 'package:social_door/Utils/socialAlertDialog.dart';

class CreateEventProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  var hostedEventList = [];

  String deviceName = '';
  String deviceVersion = '';
  String deviceID = '';

  var selectedAmentites = [];
  var selectedPrefrences = [];
  var selectedRule = [];
  var selectedCencelPolicy = [];
  var selectedCategorey = [];
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

  var rule = ["610e54a2dba82c1c9e84f171"];

  Future<void> addEvent(BuildContext context) async {
    var authenticationID =
        Provider.of<DataProvider>(context, listen: false).authenticationID;

    print('startTime: $startTime');
    print('endTime: $endTime');
    print('paymentId: $paymentId');
    print('payerId: $payerId');
    print('paypalToken: $paypalToken');
    print('longitude: $longitude');
    print('latitude: $latitude');
    print('selectedCategorey: $selectedCategorey');
    print('authenticationID: $authenticationID');

    var data = {
      'title': title,
      'category': selectedCategorey,
      'hostedDate': date,
      'startTime': startTime,
      'endTime': endTime,
      'eventPhone': phone,
      'eventEmailAddress': email,
      'eventCharges': eventcharges,
      'host': authenticationID,
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

    var token = Provider.of<DataProvider>(context, listen: false).token;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Api().addEvent
          // 'https://53e6-103-57-171-121.ngrok.io/api/user/events/addEvent'
          ),
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
    if (res.reasonPhrase.toString() == "Created") {
      socialAlertDialog(
          context,
          "Event Create Successfully!",
          "congrates! your event is created wait for admin approval. Click continue goto All Events",
          Home());
    } else {
      alertDialog(context, "Failed!", "something wrong please try");
    }
    return null;
  }

  getHostedEvents(BuildContext context) async {
    print('Get Hosted Events------------------------------');
    var authenticationID =
        Provider.of<DataProvider>(context, listen: false).authenticationID;
    print('authenticationID: $authenticationID');
    try {
      String url = Api().getHostedEvents;
      var token = Provider.of<DataProvider>(context, listen: false).token;
      final responce = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({"hostId": authenticationID}),
      );
      print("responce : ${responce.statusCode}");
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        var hostedEvents = data['hostedEvents'];
        print('hostedEvents: $hostedEvents');
        hostedEventList.clear();
        for (var i in hostedEvents) {
          HostedEventModel event = HostedEventModel(
            id: i['_id'],
            title: i['title'],
            eventCharges: i['eventCharges'],
            categoreyId: i['category']['_id'],
            categoryName: i['category']['category_name'],
            eventThumbNail: i['eventThumbNail'],
            hostedDate: i['hostedDate'],
          );
          hostedEventList.add(event);
        }
        return hostedEventList;
      } else {
        print("hosted responce not true");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
