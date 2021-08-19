import 'package:flutter/material.dart';
import 'package:social_door/Constant/constant.dart';

class Api {
  String login = BASE_URL + '/api/user/login';

  String register = BASE_URL + '/api/user/register';

  String reset_password = BASE_URL + '/api/user/recover';

  updatePassword(var verifyToken) {
    return BASE_URL + '/api/user/reset/$verifyToken';
  }

  codeConfirmation(var currentText) {
    return BASE_URL + '/api/user/reset/$currentText';
  }

  // Social Login Api's
  String loginGoogle = BASE_URL + "/api/user/socialLoginWithGoogle";

  String loginFacebook = BASE_URL + "/api/user/socialLoginWithFacebook";

  // Home Api's
  String getAllTags = BASE_URL + "/api/user/getAllTags";

  //Event Post
  String createEvent = BASE_URL + "/api/user/events/eventCreationForm";
  // GEt All Events
  String getEvents = BASE_URL + "/api/user/events/getEvents";
  String getEventMedia = BASE_URL + "/media/";
}
