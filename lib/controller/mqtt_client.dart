//Send data via Mqtt

// ignore_for_file: avoid_print

import 'dart:math';

import 'package:lamp_control/controller/controller.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClient {
  final Function(bool status) updateState;

  MqttClient({required this.updateState});


 //Generate client ID
  String _generateClientId() {
    final random = Random();
    final clientId = 'flutter_client_${random.nextInt(10000)}';
    return clientId;
  }

// Melakaukan koneksi ke wifi
  Future<void> connect() async {
    final clientId = _generateClientId();
    client = MqttServerClient('test.mosquitto.org', clientId);
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.logging(on: true);

    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMess;

    try {
      print('Connecting to broker...');
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
      return;
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected');
      updateState(isconnect = false);
    } else {
      print(
          'ERROR: MQTT connection failed - disconnecting, status is ${client.connectionStatus!.state}');
      client.disconnect();
    }
  }

  void onConnected() {
    print('Connected to the broker.');
  }

  void onDisconnected() {
    print('Disconnected from the broker.');
    updateState(isconnect = false);
  }

 // Function untuk mengirimn pesan ke topic pada broker
  void toggleLED(String state) {
    if (isconnect) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(state);
      client.publishMessage(
          'flutter/toogle/lamp', MqttQos.atLeastOnce, builder.payload!);
    }
  }
}
