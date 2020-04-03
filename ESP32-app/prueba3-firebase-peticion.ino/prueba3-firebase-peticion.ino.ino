
/*
 * Created by K. Suwatchai (Mobizt)
 * Email: k_suwatchai@hotmail.com
 * Github: https://github.com/mobizt
 * Copyright (c) 2019 mobizt
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
//#define path "/led-prueba"
#define path "/prueba-hardware"
#define path_disponible "/prueba-hardware/disponible"
#define path_estado "/prueba-hardware/estado"
#define path_total "/prueba-hardware/total"
#define path_peticion "/prueba-hardware/peticion"
//2. Define FirebaseESP8266 data object for data sending and receiving
FirebaseData firebaseData;

int  total = 500;

#define D0 16
#define D4 2


void setup()
{
  
  pinMode(D4,OUTPUT);
  digitalWrite(D4, LOW);
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

  if(Firebase.setInt(firebaseData, path_total, total)) {
    Serial.println("ACTUALIZADO" );
  } else {
    Serial.println("TENEMOS PROBLEMAS CON EL SETEO TOTAL" );
    Serial.println(firebaseData.errorReason());
  }
    
  
}



void loop()
{
  
   if(Firebase.getInt(firebaseData, path_peticion)) {
       //Success
    int peticion =firebaseData.intData();

    if(peticion==0) {
      Serial.println("PERFECT");
    }else if(total>=peticion) {
      if((Firebase.setInt(firebaseData, path_peticion, 0)) and (Firebase.setInt(firebaseData, path_total, total-peticion))) {
          Serial.println("PERFECT");
          //setear disponible false, estado true
          total = total - peticion;
          digitalWrite(D4, HIGH);
          delay(peticion*100); //1000 -> 1 seg
          digitalWrite(D4, LOW);
      } else {
          Serial.println("TENEMOS PROBLEMAS CON EL SETEO PETICION y TOTAL" );
          Serial.println(firebaseData.errorReason());
      }
    } else if( total<peticion ) {  //estado y disponible false
      if((Firebase.setBool(firebaseData, path_disponible, false)) and (Firebase.setBool(firebaseData, path_estado, false))) {
        Serial.println("PERFECT");
        } else {
            Serial.println("TENEMOS PROBLEMAS CON EL SETEO DISPONIBLE y ESTADO" );
            Serial.println(firebaseData.errorReason());
        }  
    }
    else {
      
        Serial.println("TERMINAMOS" );
        digitalWrite(D4, LOW);
    }
 
  }else{
    //Failed?, get the error reason from firebaseData

    Serial.print("TENEMOS PROBLEMAS CON EL GETEO");
    Serial.println(firebaseData.errorReason());
  }

 

    // put your main code here, to run repeatedly:
  //digitalWrite(D4, LOW);
  //delay(1000);
  //digitalWrite(D4, HIGH);
  //delay(1000);
  
}
