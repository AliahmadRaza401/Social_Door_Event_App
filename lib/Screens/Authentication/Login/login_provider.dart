import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Screens/Authentication/dataProvider.dart';
import 'package:social_door/common_widget/commom_widget.dart';

class LoginProvider extends ChangeNotifier{
    late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  

}