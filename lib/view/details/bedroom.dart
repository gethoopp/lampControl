import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamp_control/controller/controller.dart';
import 'package:lamp_control/controller/mqtt_client.dart';

class Bedroom extends StatefulWidget {
  const Bedroom({super.key});

  @override
  State<Bedroom> createState() => _BedroomState();
}



class _BedroomState extends State<Bedroom> {
  bool islampON = false;
  late MqttClient mqttClient;

  @override
  void initState() {
    super.initState();

    mqttClient = MqttClient((bool status) {
      setState(() {
        isLampon = status;
      });
    });

    
  }
  
  void updateLamp (bool val) {
    setState(() {
      islampON = val;
    });

    if (isLampon) {
      String msg = val ? 'on' : 'off';
      mqttClient.toggleLED(msg);
    }
     
  }

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'Assets/images/lampu.png',
                    ),
                    fit: BoxFit.cover)),
            width: size.width * 1,
            height: size.height * 0.6,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.3,left: size.width * 0.08),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Back',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      right: size.width * 0.5,
                    ),
                    child: Container(
                        color: Colors.grey[400],
                        width: size.width * 0.3,
                        height: size.height * 0.03,
                        child: Text(
                          icons[1]['name'],
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ))),

                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: size.width * 0.08,top: size.height * 0.03 ),
                              child: Switch(value: islampON, onChanged: updateLamp,activeColor: Colors.lightGreen,),
                            ),

                            
                          ],
                        )
              ],
            ),
          ),
        ],
      ),
    ]));
  }
}
