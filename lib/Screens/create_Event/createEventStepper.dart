import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Screens/create_Event/create_event_provider.dart';
import 'package:social_door/Screens/create_Event/stepspage.dart';

class CreateEventStepper extends StatefulWidget {
  @override
  _CreateEventStepperState createState() => _CreateEventStepperState();
}

class _CreateEventStepperState extends State<CreateEventStepper> {
  int _currentStep = 0;
  bool value = false;
  StepperType stepperType = StepperType.vertical;

  var eventCharges;
  var eventRule;
  var eventPrefrence;
  var eventAmentities;
  var eventCategory;
  var eventCancelPolicy;
  bool selectedAmen = false;
  bool selectedPref = false;
  bool selectedRul = false;
  bool selectedcanp = false;

  final selectedAmentites = [];
  final selectedPrefrences = [];
  final selectedRule = [];
  final selectedCencelPolicy = [];

  var hostedDate;
  var startTime;
  var endTime;

  TextEditingController title = TextEditingController();
  TextEditingController categorey = TextEditingController();
  TextEditingController volNumber = TextEditingController();
  TextEditingController host = TextEditingController();
  TextEditingController userIns = TextEditingController();
  TextEditingController eventcharges = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController home = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postelCode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();

  var _cordinates;

  createEvent(BuildContext context) async {
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
      eventRule = createEventData.eventCreationData.eventRulesList;
      eventAmentities = createEventData.eventCreationData.eventAmenitiesList;
      eventCategory = createEventData.eventCreationData.eventCategoryList;
      eventCharges = createEventData.eventCreationData.eventChargesList;
      eventPrefrence = createEventData.eventCreationData.eventPrefrencesList;
      eventCancelPolicy =
          createEventData.eventCreationData.eventCancellationPolicyList;
    }
  }

  late CreateEventProvider _createEventProvider;
  var createEventData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createEvent(context);

    _getCurrentLocation();
    _createEventProvider =
        Provider.of<CreateEventProvider>(context, listen: false);
    _createEventProvider.deviceDetails();
  }

  createMyEvent() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => PaypalPayment(
    //       totalAmount: 1,
    //       onFinish: (number) async {
    //         // payment done
    //         print('order id: ' + number);
    //         CommomWidget().showAlertDialog(context, "payment Done");
    //       },
    //     ),
    //   ),
    // );

    _createEventProvider.title = title.text.toString();
    _createEventProvider.categorey = categorey.text.toString();
    _createEventProvider.city = city.text.toString();
    _createEventProvider.cordinates = _cordinates;
    // _createEventProvider.date = date.text.toString();
    _createEventProvider.description = description.text.toString();
    _createEventProvider.email = email.text.toString();
    _createEventProvider.endTime = endTime.text.toString();
    _createEventProvider.eventcharges = eventcharges.text.toString();
    _createEventProvider.floor = floor.text.toString();
    _createEventProvider.home = home.text.toString();
    _createEventProvider.host = host.text.toString();
    _createEventProvider.postelCode = postelCode.text.toString();
    _createEventProvider.phone = phone.text.toString();
    _createEventProvider.startTime = startTime.text.toString();
    _createEventProvider.street = street.text.toString();
    _createEventProvider.type = type.text.toString();
    _createEventProvider.userIns = userIns.text.toString();
    _createEventProvider.volNumber = volNumber.text.toString();
    _createEventProvider.selectedAmentites = selectedAmentites;
    _createEventProvider.selectedCencelPolicy = selectedCencelPolicy;
    _createEventProvider.selectedPrefrences = selectedPrefrences;
    _createEventProvider.selectedRule = selectedRule;

    _createEventProvider.addEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffF5F5F5),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Text(
                      "Add Event",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Theme(
                  data: ThemeData(
                    colorScheme: Theme.of(context)
                        .colorScheme
                        .copyWith(primary: Color(0xffff5018)),
                  ),
                  child: Stepper(
                    controlsBuilder: (BuildContext context,
                        {onStepContinue, onStepCancel}) {
                      return Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed:
                                _currentStep == 9 ? createMyEvent : continued,
                            child: _currentStep == 9
                                ? Text(r"Create Event 1$")
                                : Text('Continue'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[400]),
                            ),
                            onPressed: cancel,
                            child: const Text('Back'),
                          ),
                        ],
                      );
                    },
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    // onStepContinue: _currentStep == 9 ? null : continued,
                    // onStepCancel: _currentStep == 9 ? null : cancel,
                    steps: <Step>[
                      Step(
                        title: new Text('Title'),
                        content: firstPage(context, title, categorey, volNumber,
                            host, userIns, eventcharges),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Amenities'),
                        content: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: eventAmentities == null
                                    ? 0
                                    : eventAmentities.length,
                                itemBuilder: (context, i) {
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(eventAmentities[i].title),
                                    value: selectedAmen,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAmen = value!;
                                        if (value == true) {
                                          selectedAmentites
                                              .add(eventAmentities[i].title);
                                        } else {
                                          selectedAmentites
                                              .remove(eventAmentities[i].title);
                                        }
                                      });
                                      print(selectedAmentites);
                                    },
                                  );
                                })
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Prefrences '),
                        content: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: eventAmentities == null
                                    ? 0
                                    : eventAmentities.length,
                                itemBuilder: (context, i) {
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title:
                                        Text(eventPrefrence[i].prefrenceValue),
                                    value: selectedPref,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPref = value!;
                                        if (value == true) {
                                          selectedPrefrences.add(
                                              eventPrefrence[i].prefrenceValue);
                                        } else {
                                          selectedPrefrences.remove(
                                              eventPrefrence[i].prefrenceValue);
                                        }
                                      });
                                      print(selectedPrefrences);
                                    },
                                  );
                                })
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Rule '),
                        content: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: eventAmentities == null
                                    ? 0
                                    : eventAmentities.length,
                                itemBuilder: (context, i) {
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(eventRule[i].title),
                                    subtitle: Text(eventRule[i].description),
                                    value: selectedRul,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRul = value!;
                                        if (value == true) {
                                          selectedRule.add(eventRule[i].title);
                                        } else {
                                          selectedRule
                                              .remove(eventRule[i].title);
                                        }
                                      });
                                      print(selectedRule);
                                    },
                                  );
                                })
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Cancel Policy'),
                        content: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: eventAmentities == null
                                    ? 0
                                    : eventAmentities.length,
                                itemBuilder: (context, i) {
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(eventCancelPolicy[i].title),
                                    subtitle:
                                        Text(eventCancelPolicy[i].description),
                                    value: selectedcanp,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedcanp = value!;
                                        if (value == true) {
                                          selectedCencelPolicy
                                              .add(eventCancelPolicy[i].title);
                                        } else {
                                          selectedCencelPolicy.remove(
                                              eventCancelPolicy[i].title);
                                        }
                                      });
                                      print(selectedCencelPolicy);
                                    },
                                  );
                                })
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 4
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Date & Time'),
                        content: Container(
                          child: Column(
                            children: [
                              Card(
                                child: ListTile(
                                  leading: Icon(Icons.date_range_outlined),
                                  title: Text('One-line with both widgets'),
                                  trailing: Icon(Icons.more_vert),
                                ),
                              ),
                              eventDate(),
                              eventStartTime(),
                              eventEndTime()
                            ],
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 5
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Address'),
                        content: sevenPage(context, type, home, street, floor,
                            city, postelCode),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 6
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Contact Detail'),
                        content: eightPage(context, email, phone),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 7
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Descripton'),
                        content: ninePage(context, description),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 8
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Add Media'),
                        content: tenPage(context, () {
                          print("Click btn");
                        }),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 9
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.list),
      //   onPressed: switchStepsType,
      // ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 9 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Widget eventStartTime() {
    return TextButton(
        onPressed: () {
          DatePicker.showTime12hPicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm start Time : $date');
            setState(() {
              startTime = "${date.hour} : ${date.minute}";
            });
          }, currentTime: DateTime.now());
        },
        child: Text(
          'Start Time AM/PM',
          style: TextStyle(color: Colors.blue),
        ));
  }

  Widget eventEndTime() {
    return TextButton(
        onPressed: () {
          DatePicker.showTime12hPicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm End Time : $date');
            setState(() {
              endTime = "${date.hour} : ${date.minute}";
            });
          }, currentTime: DateTime.now());
        },
        child: Text(
          ' End Time AM/PM',
          style: TextStyle(color: Colors.blue),
        ));
  }

  Widget eventDate() {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2015, 3, 5),
              maxTime: DateTime(2021, 6, 7),
              theme: DatePickerTheme(
                  headerColor: Colors.orange,
                  backgroundColor: Colors.blue,
                  itemStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm ${date.year}-${date.month}-${date.day}');
            setState(() {
              hostedDate = "${date.year}-${date.month}-${date.day}";
            });
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: Text(
          'show date picker',
          style: TextStyle(color: Colors.blue),
        ));
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _cordinates = position;
      });
      print("----------Current Location----------------- + $_cordinates");
    }).catchError((e) {
      print(e);
    });
  }
}
