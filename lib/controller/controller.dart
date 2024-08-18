import 'package:lamp_control/view/home/homepage.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

int selectedIndex = 0;
late MqttServerClient client;
bool isconnect = false;
bool isPressed = false;

List<Map<String, dynamic>> icons = [
  {
    "images": 'Assets/icon/gate.png', 
    "page": const Homepage()},
  {
    "images": 'Assets/icon/bedroom.png',
    "page": const Homepage(),
  },
  {
    "images": 'Assets/icon/kitchen.png', 
    "page": const Homepage()},
  {
    "images": 'Assets/icon/bath.png', 
    "page": const Homepage()},
  {
    "images": 'Assets/icon/laundry.png', 
    "page": const Homepage()},

    {
    "images": 'Assets/icon/garage.png', 
    "page": const Homepage()
    },

    {
    "images": 'Assets/icon/dining.png', 
    "page": const Homepage()
    },


    {
    "images": 'Assets/icon/sofa.png', 
    "page": const Homepage()
    },

    {
    "images": 'Assets/icon/table.png', 
    "page": const Homepage()
    },

    {
    "images": 'Assets/icon/toilet.png', 
    "page": const Homepage()
    },

    {
    "images": 'Assets/icon/library.png', 
    "page": const Homepage()
    },





    
];
