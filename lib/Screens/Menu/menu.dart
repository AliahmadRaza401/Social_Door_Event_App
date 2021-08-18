import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Payment/paypalPayment.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';
import 'package:social_door/Screens/Post_Event/eventPostStepper.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

   @override
  userLoginFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', false);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventPostStepper()));
                },
                child: Text("create Event"),
              ),
              ElevatedButton(
                  onPressed: () {
                    // userLoginFalse();
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => Login()));

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
                  },
                  child: Text("Payment")),
              ElevatedButton(
                  onPressed: () {
                    userLoginFalse();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("LogOut")),
         ],
       ),
    );
  }
}