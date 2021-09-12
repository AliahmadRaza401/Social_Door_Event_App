import 'dart:convert';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Payment/paypalPayment.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';
import 'package:social_door/Screens/create_Event/Image_upload.dart';
import 'package:social_door/Screens/create_Event/create_event_provider.dart';
import 'package:social_door/Screens/create_Event/create_event_widget.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Utils/loading_animation.dart';
import 'package:social_door/Utils/socialAlertDialog.dart';
import 'package:social_door/common_widget/commom_widget.dart';

class CreateEventForm extends StatefulWidget {
  CreateEventForm({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _addressKey = GlobalKey<FormState>();
  final _contactKey = GlobalKey<FormState>();
  final _descKey = GlobalKey<FormState>();

  String? selectedRole = 'Writer';

  TextEditingController title = TextEditingController();
  TextEditingController categorey = TextEditingController();
  TextEditingController volNumber = TextEditingController();
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
  bool selectedcate = false;

  final selectedAmentites = [];
  final selectedPrefrences = [];
  final selectedRule = [];
  final selectedCencelPolicy = [];
  final selectedCategorey = [];

  var hostedDate;
  var startTime;
  var endTime;
  var latitude;
  var longitude;
  late DataProvider _dataProvider;
  late CreateEventProvider _createEventProvider;
  var createEventData;
  int _groupValue = -1;
  var data;
  var currentYear;
  var currentmonth;
  var currentDay;
  int startHour = 00;
  int startMint = 00;
  int endHour = 00;
  int endMint = 00;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createEvent(context);

    _getCurrentLocation();
    _createEventProvider =
        Provider.of<CreateEventProvider>(context, listen: false);
    _dataProvider = Provider.of<DataProvider>(context, listen: false);

    currentYear = DateTime.now().year;
    currentmonth = DateTime.now().month;
    currentDay = DateTime.now().day;
    print('currentDay: $currentDay');
  }

  createEvent(BuildContext context) async {
    print('createEvent: Run------------------------------');
    var token = Provider.of<DataProvider>(context, listen: false).token;
    String url = Api().createEvent;

    final responce = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print('data: $data');
      createEventData = welcomeFromJson(responce.body);
      setState(() {
        eventRule = createEventData.eventCreationData.eventRulesList;
        eventAmentities = createEventData.eventCreationData.eventAmenitiesList;
        eventCategory = createEventData.eventCreationData.eventCategoryList;
        eventCharges = createEventData.eventCreationData.eventChargesList;
        eventPrefrence = createEventData.eventCreationData.eventPrefrencesList;
        eventCancelPolicy =
            createEventData.eventCreationData.eventCancellationPolicyList;
      });
    } else {
      print("Api not Working");
    }
  }

  createMyEvent() {
    print("createMyEvent");

    setState(() {
      _createEventProvider.title = title.text.toString();
      _createEventProvider.categorey = categorey.text.toString();
      _createEventProvider.city = city.text.toString();
      _createEventProvider.latitude = latitude;
      _createEventProvider.date = hostedDate;
      _createEventProvider.startTime = startTime;
      _createEventProvider.endTime = endTime;
      _createEventProvider.description = description.text.toString();
      _createEventProvider.email = email.text.toString();
      _createEventProvider.endTime = endTime;
      _createEventProvider.eventcharges = eventcharges.text.toString();
      _createEventProvider.floor = floor.text.toString();
      _createEventProvider.home = home.text.toString();
      _createEventProvider.postelCode = postelCode.text.toString();
      _createEventProvider.phone = phone.text.toString();
      _createEventProvider.startTime = startTime;
      _createEventProvider.street = street.text.toString();
      _createEventProvider.type = type.text.toString();
      _createEventProvider.userIns = userIns.text.toString();
      _createEventProvider.volNumber = volNumber.text.toString();
      _createEventProvider.selectedAmentites = selectedAmentites;
      _createEventProvider.selectedCencelPolicy = selectedCencelPolicy;
      _createEventProvider.selectedPrefrences = selectedPrefrences;
      _createEventProvider.selectedRule = selectedRule;
      _createEventProvider.selectedCategorey = selectedCategorey;
      _createEventProvider.longitude = longitude;
    });

    socialAlertDialog(
      context,
      "Pay 1\$ Fee",
      "For create event must pay 1\$ click Continue to proceed",
      PaypalPayment(
        totalAmount: 1,
        onFinish: (number) async {
          // payment done
          print('order id: ' + number);
          CommomWidget().showAlertDialog(context, "payment Done");
        },
      ),
    );
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //      PaypalPayment(
    //       totalAmount: 1,
    //       onFinish: (number) async {
    //         // payment done
    //         print('order id: ' + number);
    //         CommomWidget().showAlertDialog(context, "payment Done");
    //       },
    //     ),
    //   ),
    // );
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
                digitInputField(
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
                digitInputField(
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
        title: 'Select your Categorey',
        subtitle: 'Choose one Categorey given list provided',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              createEventData == null
                  ? loadingAnimation(context)
                  : ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: eventCategory == null
                                ? 0
                                : eventCategory.length,
                            itemBuilder: (context, i) {
                              return RadioListTile(
                                value: i,
                                groupValue: _groupValue,
                                onChanged: (val) {
                                  setState(() {
                                    _groupValue = i;

                                    selectedCategorey.add(eventCategory[0].id);
                                    print(
                                        'selectedCategorey: $selectedCategorey');
                                  });
                                },
                                title: Text(eventCategory[0].categoryName),
                              );
                            })
                      ],
                    ),
            ],
          ),
        ),
        validation: () {
          // if (selectedCategorey.isEmpty) {
          //   return alertDialog(context, "Required!",
          //       'Please Click PREV select atleast one Categorey');
          // }
          // return null;
        },
      ),
      CoolStep(
        title: 'Select your Amenities',
        subtitle: 'Choose a amenities',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              createEventData == null
                  ? loadingAnimation(context)
                  : ListView(
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
                                          .add(eventAmentities[i].id);
                                    } else {
                                      selectedAmentites
                                          .remove(eventAmentities[i].id);
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
          // if (selectedAmentites.isEmpty) {
          //   return alertDialog(context, "Required!",
          //       'Please Click PREV select atleast one Amentites');
          // }
          // return null;
        },
      ),
      CoolStep(
        title: 'Select your Prefrences',
        subtitle: 'Choose a prefrences',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: createEventData == null
              ? loadingAnimation(context)
              : ListView(
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
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(eventPrefrence[i].prefrenceValue),
                            value: selectedPref,
                            onChanged: (value) {
                              setState(() {
                                selectedPref = value!;
                                if (value == true) {
                                  selectedPrefrences.add(eventPrefrence[i].id);
                                } else {
                                  selectedPrefrences
                                      .remove(eventPrefrence[i].id);
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
          // if (selectedPrefrences.isEmpty) {
          //   return alertDialog(context, "Required!",
          //       'Please Click PREV select atleast one Prefrences');
          // }
          // return null;
        },
      ),
      CoolStep(
        title: 'Select your Rule',
        subtitle: 'Choose a rule',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: createEventData == null
              ? loadingAnimation(context)
              : ListView(
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
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(eventRule[i].title),
                            subtitle: Text(eventRule[i].description),
                            value: selectedRul,
                            onChanged: (value) {
                              setState(() {
                                selectedRul = value!;
                                if (value == true) {
                                  selectedRule.add(eventRule[i].id);
                                } else {
                                  selectedRule.remove(eventRule[i].id);
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
          // if (selectedRule.isEmpty) {
          //   return alertDialog(context, "Required!",
          //       'Please Click PREV select atleast one Role');
          // }
          // return null;
        },
      ),
      CoolStep(
        title: 'Select your Cancel Policy',
        subtitle: 'Choose a Cancel Policy',
        content: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: createEventData == null
              ? loadingAnimation(context)
              : ListView(
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
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(eventCancelPolicy[i].title),
                            subtitle: Text(eventCancelPolicy[i].description),
                            value: selectedcanp,
                            onChanged: (value) {
                              setState(() {
                                selectedcanp = value!;
                                if (value == true) {
                                  selectedCencelPolicy
                                      .add(eventCancelPolicy[i].id);
                                } else {
                                  selectedCencelPolicy
                                      .remove(eventCancelPolicy[i].id);
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
          // if (selectedCencelPolicy.isEmpty) {
          //   return alertDialog(context, "Required!",
          //       'Please Click PREV select atleast one CencelPolicy');
          // }
          // return null;
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
        content: Form(
          key: _addressKey,
          child: Container(
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
                digitInputField(
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
                digitInputField(
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
                digitInputField(
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
        ),
        validation: () {
          if (!_addressKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Contact Details',
        subtitle: 'enter your contact details',
        content: Form(
          key: _contactKey,
          child: Container(
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
        ),
        validation: () {
          if (!_contactKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Description',
        subtitle: 'enter your details description',
        content: Form(
          key: _descKey,
          child: Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width * .1,
            child: Container(
              child: descInputField(
                context,
                "Write detail description here...",
                description,
                (value) {
                  if (value!.isEmpty) {
                    return 'description is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
        validation: () {
          if (!_descKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
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
      onCompleted: stepComplete,
      steps: steps,
      config: CoolStepperConfig(
        backText: 'PREV',
        headerColor: Color(0xff1A1A36),
        titleTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        subtitleTextStyle: TextStyle(color: Colors.white),
        iconColor: Colors.white,
      ),
    );

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        color: Color(0xff1A1A36),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: stepper,
          ),
        ),
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
        DatePicker.showTimePicker(context,
            showTitleActions: true,
            theme: DatePickerTheme(
                headerColor: Colors.orange,
                backgroundColor: Color(0xff1A1A36),
                itemStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
                doneStyle: TextStyle(color: Colors.white, fontSize: 18)),
            onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          print('confirm start Time : $date');
          setState(() {
            startHour = date.hour;
            startMint = date.minute;
            startTime = "${date.hour} : ${date.minute}";
            // startTime = date;
          });
        }, currentTime: DateTime.now());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02),
        width: MediaQuery.of(context).size.width * 0.7,
        // height: MediaQuery.of(context).size.height * 0.06,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Start Time",
                    style: TextStyle(
                        color: Color(0xffff5018),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Icon(
                  Icons.access_time,
                  color: Color(0xffff5018),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(startTime == null ? "" : startTime,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget eventEndTime() {
    return TextButton(
      onPressed: () {
        DatePicker.showTimePicker(context,
            showTitleActions: true,
            theme: DatePickerTheme(
                headerColor: Colors.orange,
                backgroundColor: Color(0xff1A1A36),
                itemStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
                doneStyle: TextStyle(color: Colors.white, fontSize: 18)),
            onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          print('confirm End Time : $date');
          setState(() {
            endHour = date.hour;
            endMint = date.minute;
            endTime = "${date.hour} : ${date.minute}";
            // endTime = date;
          });
        }, currentTime: DateTime.now());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02),
        width: MediaQuery.of(context).size.width * 0.7,
        // height: MediaQuery.of(context).size.height * 0.06,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("End Time",
                    style: TextStyle(
                        color: Color(0xffff5018),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Icon(
                  Icons.access_time,
                  color: Color(0xffff5018),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(endTime == null ? "" : endTime,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget eventDate() {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(currentYear, currentmonth, currentDay),
              maxTime: DateTime(2025, 1, 7),
              theme: DatePickerTheme(
                  headerColor: Colors.orange,
                  backgroundColor: Color(0xff1A1A36),
                  itemStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 18)),
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02),
          width: MediaQuery.of(context).size.width * 0.7,
          // height: MediaQuery.of(context).size.height * 0.06,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select Date",
                      style: TextStyle(
                          color: Color(0xffff5018),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.calendar_today,
                    color: Color(0xffff5018),
                  )
                ],
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(hostedDate == null ? "" : hostedDate,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
        ));
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        latitude = position.latitude;
        print('latitude: $latitude');
        longitude = position.longitude;
        print('longitude: $longitude');
      });
    }).catchError((e) {
      print(e);
    });
  }

  // currentDate() {
  //   var newFormat = DateFormat("yy-MM-dd");
  //   return newFormat;
  // }

  stepComplete() {
    print('Steps completed!');
    print("st + $startHour");
    print("sm + $startMint");
    print("et + $endHour");
    print("em + $endMint");

    if (selectedCategorey.isEmpty) {
      return alertDialog(
          context, "Required!", 'Please select atleast one Categorey');
    } else if (selectedCencelPolicy.isEmpty) {
      return alertDialog(context, "Required!",
          'Please Click PREV select atleast one CencelPolicy');
    } else if (selectedAmentites.isEmpty) {
      return alertDialog(
          context, "Required!", 'Please select atleast one Amentites');
    } else if (selectedPrefrences.isEmpty) {
      return alertDialog(
          context, "Required!", 'Please select atleast one Prefrences');
    } else if (selectedRule.isEmpty) {
      return alertDialog(
          context, "Required!", 'Please select atleast one Rule');
    } else if (hostedDate == null) {
      return alertDialog(context, "Required!!", 'Please enter event Date');
    }
    //  else if (startHour <= endHour) {
    //   return alertDialog(
    //       context, "Wrong!", 'your EndTime is smaller from StartTime');
    // }
    else if (_createEventProvider.imagefile == null) {
      return alertDialog(
          context, "Required!", 'Please select image for event Thumbnail');
    } else {
      createMyEvent();
    }
  }
}
