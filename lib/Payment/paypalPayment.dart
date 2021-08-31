import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Payment/paypalServices.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:social_door/Screens/create_Event/createEventStepper.dart';
import 'package:social_door/Screens/create_Event/create_event_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final double totalAmount;
  PaypalPayment({required this.onFinish, required this.totalAmount});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  late String checkoutUrl;
  late String executeUrl;
  late String accessToken;
  PaypalServices services = PaypalServices();
  late CreateEventProvider _createEventProvider;
  @override
  void initState() {
    super.initState();
    _createEventProvider =
        Provider.of<CreateEventProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = (await services.getAccessToken())!;
        final transactions = getOrderParams();
        // final transactions = widget.totalAmount;

        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          print("res: $res");
          setState(() {
            checkoutUrl = res["approvalUrl"].toString();
            executeUrl = res["executeUrl"].toString();
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  // String itemName = 'iPhone X';
  // String itemPrice = totalAmount.toString();
  // int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    // List items = [
    //   {
    //     "name": 'Lieferhome',
    //     // "quantity": 1,
    //     "price": widget.totalAmount,
    //     "currency": defaultCurrency["currency"]
    //   }
    // ];

    // checkout invoice details
    // String totalAmount = '1.99';
    // String subTotalAmount = '1.99';
    // String shippingCost = '0';
    // int shippingDiscountCost = 0;
    // String userFirstName = 'Gulshan';
    // String userLastName = 'Yadav';
    // String addressCity = 'Delhi';
    // String addressStreet = 'Mathura Road';
    // String addressZipCode = '110014';
    // String addressCountry = 'India';
    // String addressState = 'Delhi';
    // String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": widget.totalAmount,
            "currency": defaultCurrency["currency"],
            // "details": {
            //   "subtotal": widget.totalAmount,
            //   // "shipping": shippingCost,
            //   "shipping_discount":
            //   ((-1.0) * shippingDiscountCost).toString()
            // }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          // "item_list": {
          //   "items": items,
          //   if (isEnableShipping &&
          //       isEnableAddress)
          //     "shipping_address": {
          //       "recipient_name": userFirstName +
          //           " " +
          //           userLastName,
          //       "line1": addressStreet,
          //       "line2": "",
          //       "city": addressCity,
          //       "country_code": addressCountry,
          //       "postal_code": addressZipCode,
          //       "phone": addressPhoneNumber,
          //       "state": addressState
          //     },
          // }
        }
      ],
      // "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.totalAmount;
    print(checkoutUrl);
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff131941),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              final data = uri.queryParameters;
              _createEventProvider.paymentInfo = data;
              print('paymentInfo: ${_createEventProvider.paymentInfo}');
              _createEventProvider.addEvent(context);
              // addEvent();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => CreateEventStepper()));

              // if (payerID != null) {
              //   services
              //       .executePayment(executeUrl, payerID, accessToken)
              //       .then((id) {
              //     widget.onFinish(id);
              //     // Navigator.of(context).pop();
              //     print('1');
              //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderStatus()));
              //   });
              // } else {
              //   // Navigator.of(context).pop();
              //   print('2');
              //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderStatus()));

              // }
              // // Navigator.of(context).pop();
              // print('3');
              // // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderStatus()));

            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }

  addEvent() async {
    try {
      print(" ---------Ad Event------------------");
      print('email: ${_createEventProvider.title}');
      var token = Provider.of<DataProvider>(context, listen: false).token;
      final _response = await http.post(
        Uri.parse(Api().addEvent),
        headers: {
          'content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'eventThumbNail': _createEventProvider.imagefile,
          'data': {
            'title': _createEventProvider.title,
            'category': _createEventProvider.categorey,
            'hostedDate': _createEventProvider.date,
            'startTime': _createEventProvider.startTime,
            'endTime': _createEventProvider.endTime,
            'eventPhone': _createEventProvider.phone,
            'eventEmailAddress': _createEventProvider.email,
            'eventCharges': _createEventProvider.eventcharges,
            'host': _createEventProvider.host,
            'volume': _createEventProvider.volNumber,
            'rules': _createEventProvider.selectedRule,
            'prefrences': _createEventProvider.selectedPrefrences,
            'amenities': _createEventProvider.selectedAmentites,
            'userInstructions': _createEventProvider.userIns,
            'cancellationPolicy': _createEventProvider.selectedCencelPolicy,
            'venue': {
              'type': _createEventProvider.type,
              'home': _createEventProvider.home,
              'street': _createEventProvider.street,
              'floor': _createEventProvider.floor,
              'city': _createEventProvider.city,
              'postal_code': _createEventProvider.postelCode,
              'coordinates': _createEventProvider.cordinates,
            },
            'description': _createEventProvider.description,
            'paypalToken': _createEventProvider.paymentInfo
          },
        }),
      );

      print('_response------------ : $_response');
      var result = jsonDecode(_response.body);
      print('result-------: $result');
    } catch (e) {
      return e.toString();
    }
  }
}