// import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:social_door/Screens/create_Event/Image_upload.dart';
// import 'package:social_door/Screens/create_Event/create_event_widget.dart';
// import 'package:social_door/Screens/create_Event/date_time_piker.dart';

// Widget firstPage(BuildContext context, title, categorey, volNumber, host,
//     userIns, eventcharges) {
//   return Container(
//     child: Column(
//       children: [
//         titleiInputField(context, title),
//         SizedBox(
//           height: 10,
//         ),
//         categoreyInputField(context, categorey),
//         SizedBox(
//           height: 10,
//         ),
//         volumNumberiInputField(context, volNumber),
//         SizedBox(
//           height: 10,
//         ),
    
//         userinstructionInputField(context, userIns),
//         SizedBox(
//           height: 10,
//         ),
//         eventChargesInputField(context, eventcharges)
//       ],
//     ),
//   );
// }

// Widget sixPage(BuildContext context) {
//   return Container(child: DateTimePiker());
// }

// Widget sevenPage(
//     BuildContext context, type, home, street, floor, city, postelCode) {
//   return Container(
//     child: Column(
//       children: [
//         typeInputField(context, type),
//         SizedBox(
//           height: 10,
//         ),
//         homeInputField(context, home),
//         SizedBox(
//           height: 10,
//         ),
//         streetInputField(context, street),
//         SizedBox(
//           height: 10,
//         ),
//         floorInputField(context, floor),
//         SizedBox(
//           height: 10,
//         ),
//         cityInputField(context, city),
//         SizedBox(
//           height: 10,
//         ),
//         postelCodeInputField(context, postelCode),
//         SizedBox(
//           height: 10,
//         ),
//       ],
//     ),
//   );
// }

// Widget eightPage(BuildContext context, email, phone) {
//   return Container(
//     child: Column(
//       children: [
//         emailInputField(context, email),
//         SizedBox(
//           height: 10,
//         ),
//         phoneNumberInputField(context, phone)
//       ],
//     ),
//   );
// }

// Widget ninePage(BuildContext context, des) {
//   return Container(
//     child: Column(
//       children: [
//         descritionInputField(context, des)
//       ],
//     ),
//   );
// }

// Widget tenPage() {
//   return Container(
//     child: ImageUpload(),
//   );
// }

// String? validatePassword(String value) {
//   if (value.isEmpty) {
//     return "* Required";
//   } else if (value.length < 6) {
//     return "Password should be atleast 6 characters";
//   } else if (value.length > 15) {
//     return "Password should not be greater than 15 characters";
//   } else
//     return null;
// }

// Widget inputField(BuildContext context, String text, controller) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.8,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: Color(0xffEEF3F8),
//     ),
//     child: TextFormField(
//       // onChanged: (value) {
//       //   onChange = value;
//       // },
//       controller: controller,
//       validator: (value) {},
//       cursorColor: Color(0xffff5018),
//       cursorWidth: 2.0,
//       cursorHeight: 26.0,
//       decoration: new InputDecoration(
//         contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         hintText: text,
//         // prefixIcon: Padding(
//         //   padding: EdgeInsets.only(left: 1),
//         //   child: Icon(
//         //     Icons.email,
//         //     color: Color(0xffFF5018),
//         //   ),
//         // ),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           borderSide: const BorderSide(
//             color: Colors.black45,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           borderSide: BorderSide(color: Color(0xffff5018), width: 2),
//         ),
//       ),
//     ),
//   );
// }
