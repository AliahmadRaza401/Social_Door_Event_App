import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Screens/Home/home.dart';

class SocialLogin {
  String firstName;
  String lastName;
  String email;
  String profileUrl;
  String id;

  SocialLogin(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.id,
      required this.profileUrl});
// Login With Facebook
  Future loginWithFacebook() async {
    final response = await http.post(
      Uri.parse(Api().loginFacebook),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profileImage": profileUrl,
        "id": id
      }),
    );
    var data = jsonDecode(response.body);
    return data;
  }

  // Login With Google
  Future loginWithGoogle() async {
    final response = await http.post(
      Uri.parse(Api().loginGoogle),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profileImage": profileUrl,
        "id": id
      }),
    );
    var data = jsonDecode(response.body);
    return data;
  }
}
