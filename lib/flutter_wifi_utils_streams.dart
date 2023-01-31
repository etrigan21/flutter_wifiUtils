import 'dart:async';

import 'package:flutter/services.dart';

class EventChannelHandler {
   final EventChannel _wifiStream = const EventChannel("flutter_wifi_utils_events");
   StreamSubscription? _wifiStreamSubscription;
   get wifiStream{
     return _wifiStream;
   }

   void startWifiScan(){
      _wifiStreamSubscription = _wifiStream.receiveBroadcastStream().listen(_listenToWifiStream);
   }

   void cancelWiFiScan(){
     _wifiStreamSubscription!.cancel();
   }

   void _listenToWifiStream(value){
      print(value);
   }

}