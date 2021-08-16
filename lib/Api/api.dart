import 'package:flutter/material.dart';

class Api {
  String login = 'https://socialeventdoor.herokuapp.com/api/user/login';

  String register = 'https://socialeventdoor.herokuapp.com/api/user/register';

  String reset_password =
      'https://socialeventdoor.herokuapp.com/api/user/recover';

  updatePassword(var verifyToken) {
    return 'https://socialeventdoor.herokuapp.com/api/user/reset/$verifyToken';
  }

  codeConfirmation(var currentText) {
    return 'https://socialeventdoor.herokuapp.com/api/user/reset/$currentText';
  }

  // Social Login Api's
  String loginGoogle =
      "https://socialeventdoor.herokuapp.com/api/user/socialLoginWithGoogle";

  String loginFacebook =
      "https://socialeventdoor.herokuapp.com/api/user/socialLoginWithFacebook";

  // Home Api's
  String getAllTags =
      "https://socialeventdoor.herokuapp.com/api/user/getAllTags";

  //Event Post
  String createEvent =
      "https://socialeventdoor.herokuapp.com/api/user/events/eventCreationForm";
  // GEt All Events
  String getEvents =
      "https://socialeventdoor.herokuapp.com/api/user/events/getEvents";
}
