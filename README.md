# AutoChela

En

`android/build.gradle`
- dependencies {
        classpath 'com.google.gms:google-services:4.3.3'    //FIREBASE
    }

`android/app/build.gradle`
- defaultConfig {
		multiDexEnabled true
	}
- dependencies {
	implementation 'com.android.support:multidex:1.0.3' // use latest version
	}


`pubspec.yaml`
-dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
  cloud_firestore: ^0.13.4+2
  firebase_core: ^0.4.3+3
  font_awesome_flutter: ^8.5.0  #ICONOS
  google_maps_flutter: ^0.5.25+2 #MAPS
  geolocator: ^5.2.1  #ESCUCHA MYLOCATION
  geopoint: ^0.7.0
  geoflutterfire: ^2.0.3+8    #MAPS
  location: ^2.3.5    #MAPS
  geocoder: ^0.2.1    #MAPS
  google_maps_webservice: ^0.0.16  #MAPS
  floating_search_bar: ^0.3.0

  