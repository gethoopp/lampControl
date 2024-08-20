import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamp_control/controller/controller.dart';
import '../../bloc/control_light_bloc.dart';
import '../../widget/indicator_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 1,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black12, Colors.white]),
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
                    )),
                BlocBuilder<ControlLightBloc, ControlLightState>(
                  builder: (context, state) {
                    if (state is BluetoothLoading) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.58),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              height: size.height * 0.42,
                              // ignore: prefer_const_constructors
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.2,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Scanning, Wait a Minute ...',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (state is BluetoothFound) {
                      return Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: size.height * 0.58),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50))),
                                height: size.height * 0.42,
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.6, left: 30),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: size.width * 0.1),
                                  child: Text(
                                    "Scanning ",
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
                                indicatorPage(selectedIndex: selectedIndex),
                                TextButton(
                                    onPressed: () => Get.back,
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ))
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (state is BluetoothErr) {
                      return Padding(
                        padding: EdgeInsets.only(top: size.height * 0.58),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          height: size.height * 0.42,
                          child: Center(
                            child: Text(state.error, style: GoogleFonts.inter(color: Colors.black,fontSize: 20),),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
