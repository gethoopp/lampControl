import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamp_control/controller/controller.dart';
import 'package:lamp_control/controller/mqtt_client.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isLampon = false;

  void updateConn(bool val) {
    setState(() {
      isLampon = val;
    });
  }

  @override
  void initState() {
    super.initState();
    //MqttClient(updateState: updateConn).connect();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.insert_comment_sharp,
                      size: 30,
                    )),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: size.width * 0.3, top: size.height * 0.05),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                      text: 'Hii Mate \n',
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Welcome To Smart Lights',
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.w200))
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.6,
            width: size.width * 0.9,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 25.0,
                
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(icons[index]['images'])),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Tes')
                        ],
                      )
                ); 
              },
              itemCount: 10, // Jumlah item
              physics:
                  const NeverScrollableScrollPhysics(), // Mengunci scrolling
              scrollDirection: Axis.vertical, // Arah scrolling
            ),
          )
        ],
      ),
    );
  }
}
