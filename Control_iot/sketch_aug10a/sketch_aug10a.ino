#include "PubSubClient.h"
#include <WiFi.h>
#include <secrests.h>

char ssid[] = SECRET_SSID;
char pass[] = SECRET_PASS;
const char* mqttServer = "test.mosquitto.org";
int port = 1883;
char clientId[50];

int relayPin = 13;

WiFiClient espClient;
PubSubClient client(espClient);

//Fungsi Coonect wifi
void connectToWiFi() {
  Serial.begin(9600);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);
  Serial.print("Attempting to connect to WPA SSID: ");
  Serial.print(ssid);

  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  Serial.println("Connected to WiFi!");
}

// Fungsi Untuk koneksi Ulang
void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    snprintf(clientId, 50, "flutter_client_%lu", random(1000));

    if (client.connect(clientId)) {
      Serial.println("connected berhasil bro");
      client.subscribe("flutter/toogle/lamp");
      Serial.println("Sudah Subscribe");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void callback(char* topic, byte* message, unsigned int length) {
  Serial.print("Message arrived on topic: ");
  Serial.print(topic);
  Serial.print(". Message: ");
  String msg;

  for (int i = 0; i < length; i++) {
    Serial.print((char)message[i]);
    msg += (char)message[i];
  }

  Serial.println();
  Serial.println("Message content: " + msg);

  if (String(topic) == "flutter/toogle/lamp") {
    Serial.println("Correct topic received");
    if (msg == "off") {
      Serial.println("Turning on relay");
      digitalWrite(relayPin, HIGH);
    } else if (msg == "on") {
      Serial.println("Turning off relay");
      digitalWrite(relayPin, LOW);

    }  else {
      Serial.println("Not recognized");
    }
  } else {
    Serial.println("Topic not recognized");
  }
}

void setup() {
  
  Serial.println("Hello ESP32 WROOM");

  Serial.print("Connecting to ");
  Serial.println(ssid);

  connectToWiFi();

  client.setServer(mqttServer, port);
  client.setCallback(callback);

  pinMode(relayPin, OUTPUT);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }

  client.loop();
 
}
