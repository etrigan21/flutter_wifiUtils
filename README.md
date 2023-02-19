# flutter_wifi_utils

This is a personal test project as a way for me to learn the development of flutter plugins. This project utilizes the ThanosFisherman's WifiUtils to provide the user controls over an Android phone's WiFi. 
This plugin is particularly useful when dealing with IoT projects. Due to the recent Android updates, network abilities are removed for devices running Android Q or later. 

## Usage

1. Instantiation

```Dart

// Imports
import 'package:flutter_wifi_utils/flutter_wifi_utils.dart';


FlutterWifiUtils _flutterWifiUtils = FlutterWifiUtils();

```

2. Toggling of WiFi module

This function redirect the user to the Android System's WiFi management screen.

```Dart

_flutterWifiUtilsPlugin.toggleWiFi();

```

3. Disconnecting from In-App connected WiFi

The disconnect function only works for WiFi networks added using the FlutterWifiUtils plugin. This will not be able to remove and disconnect from the previous network that is connected to via other means. 

```Dart
_flutterWifiUtilsPlugin.disconnectAndRemoveWiFi(SSID: ssid).then((value){
                      //Perform Callback here
                    });
```

4. Connect to Network

This function connectes the mobile device to the desired network without giving it the network capabilities. This means that this works best when used as a mode of connecting to IoT devices where no network is needed. 

```Dart
_flutterWifiUtils.connectToWiFi(SSID: _ssidController.text, password: _passwordController.text).then((value){
                    //Do Callback
                  })
```

5. Start WiFi Scanning 

This function allows the mobile application to scan for nearby WiFi networks. The value argument on the onReceive arguement is an __Instance of List<ScanResults>__.

```Dart
                  _flutterWifiUtilsPlugin.startScan(onReceive: (value)=>{
                    //Do Callback here
                  });
```

The ScanResult model is modelled as such:

```
    {
      "SSID" : String,
      "BSSID": String,
      "level": int,
      "frequency": int,
      "timestamp": int?,
      "passpoint": bool?,
      "channelBandwidth": int?,
      "centerFreq0": int?,
      "centerFreq1": int?,
      "standard": int?
    }
```

6. Stop Scanning 

```Dart
    _flutterWifiUtilsPlugin.stopScan();
```