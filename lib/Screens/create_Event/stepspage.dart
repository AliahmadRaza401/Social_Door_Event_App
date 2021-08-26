import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_door/Screens/create_Event/Image_upload.dart';
import 'package:social_door/Screens/create_Event/date_time_piker.dart';

Widget firstPage(BuildContext context, title, categorey, volNumber, host,
    userIns, eventcharges) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Title", title),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Categorey", categorey),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Volumn Number", volNumber),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Host", host),
        SizedBox(
          height: 10,
        ),
        inputField(context, "User Instructions", userIns),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Event Charges", eventcharges),
      ],
    ),
  );
}

Widget sixPage(BuildContext context) {
  return Container(child: DateTimePiker());
}

Widget sevenPage(
    BuildContext context, type, home, street, floor, city, postelCode) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Type", type),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Home", home),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Street", street),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Floor", floor),
        SizedBox(
          height: 10,
        ),
        inputField(context, "City", city),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Postel Code", postelCode),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

Widget eightPage(BuildContext context, email, password) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Email", email),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Phone No", password),
      ],
    ),
  );
}

Widget ninePage(BuildContext context, des) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Description", des),
      ],
    ),
  );
}

Widget tenPage(BuildContext context, fun) {
  return Container(child: null
      // ImageUpload(),
      );
}

Widget inputField(BuildContext context, String text, controller) {
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
        EmailValidator(errorText: "enter a valid email address"),
        RequiredValidator(errorText: "Required")
      ]),
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: text,
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
