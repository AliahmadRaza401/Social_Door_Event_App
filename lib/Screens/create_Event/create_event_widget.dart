import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';


  Widget space(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .01,
  );
}


Widget titleiInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        } else if (value.length < 3) {
          return "your title is too short";
        }
        return null;
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Title",
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

Widget categoreyInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
        return null;
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Categorey",
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

Widget userinstructionInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
        return null;
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "User Instruction",
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

Widget volumNumberiInputField(BuildContext context, controller) {
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
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
        return null;
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Volumn Number",
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

Widget eventChargesInputField(BuildContext context, controller) {
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
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Event Charges",
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

Widget typeInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Type",
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

Widget homeInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "home",
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

Widget streetInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
      },
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Street",
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

Widget floorInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Floor",
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

Widget cityInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Requied";
        }
      },

      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "City",
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

Widget postelCodeInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Postel Code",
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

Widget emailInputField(BuildContext context, controller) {
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
        hintText: "Email",
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

Widget phoneNumberInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        } else if (value.length != 13) {
          return "unvalid : +923010000000";
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Phone Number",
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

Widget descritionInputField(BuildContext context, controller) {
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
      },

      cursorColor: Color(0xffff5018),
      cursorWidth: 2.0,
      cursorHeight: 26.0,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        hintText: "Description",
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
