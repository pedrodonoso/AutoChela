
/*
 * Created by K. Suwatchai (Mobizt)
 * 
 * Email: k_suwatchai@hotmail.com
 * 
 * Github: https://github.com/mobizt
 * 
 * Copyright (c) 2019 mobizt
 * 
 * This example is for the beginner
 *
*/


#include <WiFi.h>
#include <FirebaseESP32.h>

//1. Change the following info
#define FIREBASE_HOST "https://flutterapp13.firebaseio.com"
#define FIREBASE_AUTH "c22tyqz0enwMaUHXiwVe3r9K7Yvcg4LoTNYX8qGM"
#define WIFI_SSID "VTR-5181707"
#define WIFI_PASSWORD "Yy7hjdjx7zhx"
#define path "/led-prueba"

//2. Define FirebaseESP8266 data object for data sending and receiving
FirebaseData firebaseData;


#define D0 16
#define D4 2


void setup()
{

  pinMode(D4,OUTPUT);
  Serial.begin(115200);
  Serial.println("Bienvenido a AUTO CHELA");
  int i = 0;


  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();


  //3. Set your Firebase info

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);

  //4. Enable auto reconnect the WiFi when connection lost
  Firebase.reconnectWiFi(true);


  /*

  In case where you want to set other data types i.e. bool, float, double and String, you can use setBool, setFloat, setDouble and setString.
  If you want to get data which you known its type at specific node, use getInt, getBool, getFloat, getDouble, getString.
  If you don't know the data type at specific node, use get and check its type.

  The following shows how to get the variant data

  */


  /*

  If you want to get the data in realtime instead of using get, see the stream examples.
  If you want to work with JSON, see the FirebaseJson, jsonObject and jsonArray examples.

  If you have questions or found the bugs, feel free to open the issue here https://github.com/mobizt/Firebase-ESP32

  */




}

void loop()
{
   if(Firebase.getBool(firebaseData, path))
  {
    bool estado = firebaseData.boolData();
    //Success
    Serial.print("Get bool data success = ");
    Serial.println(firebaseData.boolData());
    if(estado) {
      Serial.print("Estado es apagado" );
      Serial.println(estado);
      digitalWrite(D4, LOW);
    } else {
      Serial.print("Estado es encendido" );
      Serial.println(estado);
      digitalWrite(D4, HIGH);
    }

  }else{
    //Failed?, get the error reason from firebaseData

    Serial.print("Error in getbool, ");
    Serial.println(firebaseData.errorReason());
  }

    // put your main code here, to run repeatedly:
  //digitalWrite(D4, LOW);
  //delay(1000);
  //digitalWrite(D4, HIGH);
  //delay(1000);
  
}
