import 'package:lamp_control/view/details/bedroom.dart';
import 'package:lamp_control/view/home/homepage.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

int selectedIndex = 0;
late MqttServerClient client;
bool isconnect = false;
bool isPressed = false;
 bool isLampon = false;

List<Map<String, dynamic>> icons = [
  {
    "images": 'Assets/icon/gate.png', 
    "page": const Homepage(),
    "name": "Gerbang"
    
    
  },
  {
    "images": 'Assets/icon/bedroom.png',
    "page": const Bedroom(),
    "name": "Kamar Utama"
  },
  
  {
    "images": 'Assets/icon/kitchen.png', 
    "page": const Homepage(),
    "name": "Dapur"
    
    },
    
  {
    "images": 'Assets/icon/bath.png', 
    "page": const Homepage(),
    "name": "Kamar Mandi"
    
    },
  {
    "images": 'Assets/icon/laundry.png', 
    "page": const Homepage(),
    "name": "Cuci Baju"
    },

    {
    "images": 'Assets/icon/garage.png', 
    "page": const Homepage(),
    "name": "Garasi"
    },

    {
    "images": 'Assets/icon/dining.png', 
    "page": const Homepage(),
    "name": "Ruang Makan"
    },


    {
    "images": 'Assets/icon/sofa.png', 
    "page": const Homepage(),
    "name": "Sofa"
    },

    {
    "images": 'Assets/icon/table.png', 
    "page": const Homepage(),
    "name": "Meja Makan"
    },

    {
    "images": 'Assets/icon/toilet.png', 
    "page": const Homepage(),
    "name": "Toilet"
    },

    {
    "images": 'Assets/icon/library.png', 
    "page": const Homepage(),
    "name": "Baca Buku"
    },





    
];
