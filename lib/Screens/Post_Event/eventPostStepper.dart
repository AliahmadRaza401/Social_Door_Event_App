import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Api/postEvent.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:social_door/Screens/Post_Event/stepspage.dart';
import 'package:http/http.dart' as http;

class EventPostStepper extends StatefulWidget {
  @override
  _EventPostStepperState createState() => _EventPostStepperState();
}

class _EventPostStepperState extends State<EventPostStepper> {
  int _currentStep = 0;
  bool value = false;
  StepperType stepperType = StepperType.vertical;

  var eventCharges;
  var eventRule;
  var eventPrefrence;
  var eventAmentities;
  var eventCategory;
  var eventCancelPolicy;

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
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: new Text('Title'),
                        content: firstPage(context),
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
                                  return Row(
                                    children: [
                                      Text(eventAmentities[i].title),
                                      Checkbox(
                                        value: this.value,
                                        onChanged: (value) {
                                          setState(() {
                                            this.value = value!;
                                          });
                                        },
                                      ),
                                    ],
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
                                  return Row(
                                    children: [
                                      Text(eventPrefrence[i].prefrenceValue),
                                      Checkbox(
                                        value: this.value,
                                        onChanged: (value) {
                                          setState(() {
                                            this.value = value!;
                                          });
                                        },
                                      ),
                                    ],
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
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(eventRule[i].title),
                                          Checkbox(
                                            value: this.value,
                                            onChanged: (value) {
                                              setState(() {
                                                this.value = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(eventRule[i].description)
                                        ],
                                      ),
                                    ],
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
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(eventCancelPolicy[i].title),
                                          Checkbox(
                                            value: this.value,
                                            onChanged: (value) {
                                              setState(() {
                                                this.value = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(eventCancelPolicy[i].description)
                                        ],
                                      ),
                                    ],
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
                        content: sixPage(context),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 5
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Address'),
                        content: sevenPage(context),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 6
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Acoount Detail'),
                        content: eightPage(context),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 7
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
    _currentStep < 7 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
