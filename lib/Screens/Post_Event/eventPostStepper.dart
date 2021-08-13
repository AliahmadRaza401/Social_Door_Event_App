import 'package:flutter/material.dart';
import 'package:social_door/Screens/Post_Event/stepspage.dart';

class EventPostStepper extends StatefulWidget {
  @override
  _EventPostStepperState createState() => _EventPostStepperState();
}

class _EventPostStepperState extends State<EventPostStepper> {
  int _currentStep = 0;
  bool value = false;
  StepperType stepperType = StepperType.vertical;

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
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Text("amenities"),
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
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Prefrences '),
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Text("prefrences 1"),
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
                                Text("prefrences 2"),
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
                                Text("prefrences 2"),
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
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Rule '),
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Text("rule 1"),
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
                                Text("rule 2"),
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
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Cancel Policy'),
                        content: fivePage(context),
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
