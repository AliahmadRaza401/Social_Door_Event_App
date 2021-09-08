import 'package:flutter/material.dart';


  Widget space(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .01,
  );
}

Widget inputField(BuildContext context, title,
      TextEditingController controller, FormFieldValidator<String> validator,) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffEEF3F8),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
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