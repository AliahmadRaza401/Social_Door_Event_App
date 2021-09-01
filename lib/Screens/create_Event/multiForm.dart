import 'dart:convert';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Payment/paypalPayment.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:social_door/Screens/create_Event/Image_upload.dart';
import 'package:social_door/Screens/create_Event/create_event_provider.dart';
import 'package:social_door/Screens/create_Event/create_event_widget.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/common_widget/commom_widget.dart';

class CreateEventForm extends StatefulWidget {
  CreateEventForm({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRole = 'Writer';

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
  var _cordinates;

  late CreateEventProvider _createEventProvider;
  var createEventData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createEvent(context);

    // _getCurrentLocation();
    _createEventProvider =
        Provider.of<CreateEventProvider>(context, listen: false);
    _createEventProvider.deviceDetails();
  }

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
      print('data: $data');
      var createEventData = welcomeFromJson(responce.body);
      eventRule = createEventData.eventCreationData.eventRulesList;
      eventAmentities = createEventData.eventCreationData.eventAmenitiesList;
      eventCategory = createEventData.eventCreationData.eventCategoryList;
      eventCharges = createEventData.eventCreationData.eventChargesList;
      eventPrefrence = createEventData.eventCreationData.eventPrefrencesList;
      eventCancelPolicy =
          createEventData.eventCreationData.eventCancellationPolicyList;
    } else {
      print("Api not Working");
    }
  }

  createMyEvent() {
    print("cl;ick");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(
          totalAmount: 1,
          onFinish: (number) async {
            // payment done
            print('order id: ' + number);
            CommomWidget().showAlertDialog(context, "payment Done");
          },
        ),
      ),
    );

    _createEventProvider.title = title.text.toString();
    _createEventProvider.categorey = categorey.text.toString();
    _createEventProvider.city = city.text.toString();
    _createEventProvider.cordinates = _cordinates;
    _createEventProvider.date = hostedDate;
    _createEventProvider.startTime = startTime;
    _createEventProvider.endTime = endTime;
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
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        content: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                inputField(
                  context,
                  "Title",
                  title,
                  (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                space(context),
                inputField(
                  context,
                  "Categorey",
                  categorey,
                  (value) {
                    if (value!.isEmpty) {
                      return 'Categorey is required';
                    }
                    return null;
                  },
                ),
                space(context),
                inputField(
                  context,
                  "Volumn Number",
                  volNumber,
                  (value) {
                    if (value!.isEmpty) {
                      return 'Volumn Number is required';
                    }
                    return null;
                  },
                ),
                space(context),
                inputField(
                  context,
                  "User Instruction",
                  userIns,
                  (value) {
                    if (value!.isEmpty) {
                      return 'User Instruction is required';
                    }
                    return null;
                  },
                ),
                space(context),
                inputField(
                  context,
                  "Event Charges",
                  eventcharges,
                  (value) {
                    if (value!.isEmpty) {
                      return 'Event charges is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Select your Amenities',
        subtitle: 'Choose a amenities',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount:
                          eventAmentities == null ? 0 : eventAmentities.length,
                      itemBuilder: (context, i) {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(eventAmentities[i].title),
                          value: selectedAmen,
                          onChanged: (value) {
                            setState(() {
                              selectedAmen = value!;
                              if (value == true) {
                                selectedAmentites.add(eventAmentities[i].title);
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
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Select your Prefrences',
        subtitle: 'Choose a prefrences',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount:
                      eventAmentities == null ? 0 : eventAmentities.length,
                  itemBuilder: (context, i) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(eventPrefrence[i].prefrenceValue),
                      value: selectedPref,
                      onChanged: (value) {
                        setState(() {
                          selectedPref = value!;
                          if (value == true) {
                            selectedPrefrences
                                .add(eventPrefrence[i].prefrenceValue);
                          } else {
                            selectedPrefrences
                                .remove(eventPrefrence[i].prefrenceValue);
                          }
                        });
                        print(selectedPrefrences);
                      },
                    );
                  })
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Select your Rule',
        subtitle: 'Choose a rule',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount:
                      eventAmentities == null ? 0 : eventAmentities.length,
                  itemBuilder: (context, i) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(eventRule[i].title),
                      subtitle: Text(eventRule[i].description),
                      value: selectedRul,
                      onChanged: (value) {
                        setState(() {
                          selectedRul = value!;
                          if (value == true) {
                            selectedRule.add(eventRule[i].title);
                          } else {
                            selectedRule.remove(eventRule[i].title);
                          }
                        });
                        print(selectedRule);
                      },
                    );
                  })
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Select your Cancel Policy',
        subtitle: 'Choose a Cancel Policy',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount:
                      eventAmentities == null ? 0 : eventAmentities.length,
                  itemBuilder: (context, i) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(eventCancelPolicy[i].title),
                      subtitle: Text(eventCancelPolicy[i].description),
                      value: selectedcanp,
                      onChanged: (value) {
                        setState(() {
                          selectedcanp = value!;
                          if (value == true) {
                            selectedCencelPolicy
                                .add(eventCancelPolicy[i].title);
                          } else {
                            selectedCencelPolicy
                                .remove(eventCancelPolicy[i].title);
                          }
                        });
                        print(selectedCencelPolicy);
                      },
                    );
                  })
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Select your Date & Time',
        subtitle: 'Choose a Date & Time',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [eventDate(), eventStartTime(), eventEndTime()],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Select your Address',
        subtitle: 'enter your address details',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              inputField(
                context,
                "Type",
                type,
                (value) {
                  if (value!.isEmpty) {
                    return 'type is required';
                  }
                  return null;
                },
              ),
              space(context),
              inputField(
                context,
                "home",
                home,
                (value) {
                  if (value!.isEmpty) {
                    return 'home is required';
                  }
                  return null;
                },
              ),
              space(context),
              inputField(
                context,
                "Street",
                street,
                (value) {
                  if (value!.isEmpty) {
                    return 'street is required';
                  }
                  return null;
                },
              ),
              space(context),
              inputField(
                context,
                "Floor",
                floor,
                (value) {
                  if (value!.isEmpty) {
                    return 'floor is required';
                  }
                  return null;
                },
              ),
              space(context),
              inputField(
                context,
                "city",
                city,
                (value) {
                  if (value!.isEmpty) {
                    return 'city is required';
                  }
                  return null;
                },
              ),
              space(context),
              inputField(
                context,
                "Postel Code",
                postelCode,
                (value) {
                  if (value!.isEmpty) {
                    return 'postel code is required';
                  }
                  return null;
                },
              ),
              space(context),
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Contact Details',
        subtitle: 'enter your contact details',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              emailInputField(
                context,
                "Email",
                email,
              ),
              space(context),
              inputField(
                context,
                "Phone Number",
                phone,
                (value) {
                  if (value!.isEmpty) {
                    return 'phone number is required';
                  } else if (value.length < 11) {
                    return 'Please enter valid phone';
                  }
                  return null;
                },
              ),
              space(context),
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Description',
        subtitle: 'enter your details description',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              inputField(
                context,
                "Description",
                description,
                (value) {
                  if (value!.isEmpty) {
                    return 'description is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'Thumbnail',
        subtitle: 'upload your thumbnail image for event',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: ImageUpload(),
        ),
        validation: () {
          return null;
        },
      ),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        print('Steps completed!');
        createMyEvent();
      },
      steps: steps,
      config: CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: stepper,
      ),
    );
  }

  Widget emailInputField(
    BuildContext context,
    title,
    TextEditingController controller,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffEEF3F8),
      ),
      child: TextFormField(
        // onChanged: (value) {
        //   onChange = value;
        // },
        controller: controller,
        validator: MultiValidator([
          RequiredValidator(errorText: "Requied"),
          EmailValidator(errorText: "Enter valid Email address")
        ]),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          hintText: title,
          // prefixIcon: Padding(
          //   padding: EdgeInsets.only(left: 1),
          //   child: Icon(
          //     Icons.email,
          //     color: Color(0xffFF5018),
          //   ),
          // ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: const BorderSide(
              color: Colors.black45,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xffff5018), width: 2),
          ),
        ),
      ),
    );
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
