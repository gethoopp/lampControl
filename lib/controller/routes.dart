

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lamp_control/view/home/homepage.dart';
import '../view/connect_ble/first_page.dart';

appRoute() => [
   GetPage(name: '/firstPage', page: () => const FirstPage(),transition: Transition.rightToLeftWithFade,curve: Curves.easeInBack),
   GetPage(name: '/HomePage', page: () => const Homepage(),transition: Transition.rightToLeftWithFade,curve: Curves.easeInBack)

];