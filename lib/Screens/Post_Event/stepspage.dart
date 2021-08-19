import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

Widget firstPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Title"),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Categorey"),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Description"),
        
        SizedBox(
          height: 10,
        ),
        inputField(context, "Volumn Number"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "Host"),
        SizedBox(
          height: 10,
        ),
        inputField(context, "User Instructions"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "Event Charges"),
      ],
    ),
  );
}
Widget secondPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Amenities"),
        SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                        // Checkbox(
                        //   value: this.value,
                        //   onChanged: (bool value) {
                        //     setState(() {
                        //       this.value = value;
                        //     });
                        //   },
                        // ), 
      ],
    ),
  );
}
Widget thirdPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "prefreence"),

      ],
    ),
  );
}
Widget fourPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "rules"),

      ],
    ),
  );
}
Widget fivePage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "cancellation Plicy"),

      ],
    ),
  );
}
Widget sixPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Hosted Date"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "Start Time"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "End Time"),

      ],
    ),
  );
}
Widget sevenPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Type"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "Home"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "Street"),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Floor"),
        SizedBox(
          height: 10,
        ),
        inputField(context, "City"),
         SizedBox(
          height: 10,
        ),
        inputField(context, "Postel Code"),
         SizedBox(
          height: 10,
        ),
        Text("Fetching Coordinates...")

      ],
    ),
  );
}
Widget eightPage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Email"),
        SizedBox(
          height: 10,
        ),
        inputField(context, "Phone No"),
     
      ],
    ),
  );
}

Widget ninePage(BuildContext context) {
  return Container(
    child: Column(
      children: [
        inputField(context, "Description"),
     
      ],
    ),
  );
}

Widget inputField(BuildContext context, String text) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xffEEF3F8),
    ),
    child: TextFormField(
      // onChanged: (value) {
      //   email = value;
      // },
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
