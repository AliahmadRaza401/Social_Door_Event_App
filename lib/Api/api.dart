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
}
