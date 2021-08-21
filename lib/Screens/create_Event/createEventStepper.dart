import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Api/postEvent.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Payment/paypalPayment.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:http/http.dart' as http;
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
  bool selected = false;
  final selectedAmentites = [];
  final selectedPrefrences = [];
  final selectedRule = [];
  final selectedCencelPolicy = [];

  TextEditingController title = TextEditingController();
  TextEditingController categorey = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController volNumber = TextEditingController();
  TextEditingController host = TextEditingController();
  TextEditingController userIns = TextEditingController();
  TextEditingController eventcharges = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController home = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postelCode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createEvent(context);
    _getCurrentLocation();
  }

  createMyEvent() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(
          totalAmount: 10,
          onFinish: (number) async {
            // payment done
            print('order id: ' + number);
          },
        ),
      ),
    );
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
                                    value: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
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
                                    value: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
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
                                    value: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
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
                                    value: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
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
                        content: sixPage(context, date, startTime, endTime),
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
                        content: eightPage(context, email, password),
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
                          print(title.text.toString());
                          print(date.text.toString());
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

class Emun {
  Emun({required this.title});
  late String title;
  bool isSelected = false;
}
