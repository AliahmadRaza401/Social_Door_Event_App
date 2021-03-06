import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Payment/paypalServices.dart';
import 'package:social_door/Screens/create_Event/create_event_provider.dart';
import 'package:social_door/Utils/loading_animation.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool _loading = true;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  late String checkoutUrl;
  late String executeUrl = "";
  late String accessToken;
  PaypalServices services = PaypalServices();
  late CreateEventProvider _createEventProvider;
  var res;
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

        res = await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          print("res: $res");
          setState(() {
            checkoutUrl = res["approvalUrl"].toString();
            executeUrl = res["executeUrl"].toString();
            _loading = false;
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
    if (res != '') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff131941),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: res == null
            ? Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: loadingAnimation(context))
            : WebView(
                initialUrl: checkoutUrl,
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains(returnURL)) {
                    final uri = Uri.parse(request.url);
                    final payerID = uri.queryParameters['PayerID'];
                    final data = uri.queryParameters;
                    _createEventProvider.paymentId = data['paymentId'];
                    _createEventProvider.payerId = data['PayerID'];
                    _createEventProvider.paypalToken = data['token'];
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
        body: res == null
            ? Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: loadingAnimation(context))
            : Text("Oops! Please Try Again"),
      );
    }
  }
}
