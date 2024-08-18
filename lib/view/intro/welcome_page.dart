import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lamp_control/controller/mqtt_client.dart';
import 'package:lamp_control/cubit/dynamic_theme_cubit.dart';

import '../../widget/button_start.dart';

import '../../controller/controller.dart';
import '../../widget/indicator_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  bool isChangedBLE = false;
  bool isChangedWIfi = false;
  bool isDynamicTheme = false;

  @override
  Widget build(BuildContext context) {
    final themCubit = context.read<DynamicThemeCubit>();
    var isDarkthem = themCubit.state.brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.05, left: size.width * 0.03),
              child: Switch(
                value: isDarkthem,
                onChanged: (bool val) {
                  context.read<DynamicThemeCubit>().toogleThem();
                  isDarkthem = !isDarkthem;
                },
                activeColor: Colors.green,
              ),
            ),
            Container(
              height: size.height * 1,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.black12, Colors.white]),
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage('Assets/images/lampu1.png'))),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.58),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                height: size.height * 0.42,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.6, left: 30),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.1),
                    child: Text(
                      "Welcome To Smart Lights",
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Let's Make Your Home Comfortable With Brilliant Lights",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black26),
                  ),
                  buttonStart(size, updateState,
                      isChanged: isChangedBLE,
                      text: 'Get Started With Bluetooth'),
                  buttonStart(size, updateStateWifi,
                      isChanged: isChangedWIfi, text: 'Get Started With Wifi'),
                  const SizedBox(
                    height: 10,
                  ),
                  indicatorPage(selectedIndex: selectedIndex),
                  TextButton(
                      onPressed: () => Get.back,
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ))
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }

  void updateState() async {
    // Update state untuk mengubah button
    setState(() {
      isChangedBLE = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed('/firstPage');
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      selectedIndex++;
      print('ini index ke = $selectedIndex');
    });
  }

  void updateStateWifi() async {
    // Update state untuk mengubah button
    setState(() {
      isChangedWIfi = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    Get.toNamed('/HomePage');
  }
}
