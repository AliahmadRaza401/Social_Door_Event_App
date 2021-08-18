import 'package:flutter/material.dart';
import 'package:social_door/Constant/constant.dart';

class Api {
  String login = BASE_URL + '/user/login';

  String register = BASE_URL + '/user/register';

  String reset_password = BASE_URL + '/user/recover';

  updatePassword(var verifyToken) {
    return BASE_URL + '/user/reset/$verifyToken';
  }

  codeConfirmation(var currentText) {
    return BASE_URL + '/user/reset/$currentText';
  }

  // Social Login Api's
  String loginGoogle = BASE_URL + "/user/socialLoginWithGoogle";

  String loginFacebook = BASE_URL + "/user/socialLoginWithFacebook";

  // Home Api's
  String getAllTags = BASE_URL + "/user/getAllTags";

  //Event Post
  String createEvent = BASE_URL + "/user/events/eventCreationForm";
  // GEt All Events
  String getEvents = BASE_URL + "/user/events/getEvents";
}
