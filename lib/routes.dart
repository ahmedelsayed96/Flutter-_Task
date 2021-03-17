import 'dart:core';

import 'package:mobile_technologies_task/screens/registration_screen.dart';

class AppRoute {
  static const Registration = '/';

}

var routes = {
  AppRoute.Registration: (context) => RegistrationScreen(),

};
