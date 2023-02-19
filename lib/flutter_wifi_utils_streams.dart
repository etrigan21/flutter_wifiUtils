import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_wifi_utils/ScanResult.model.dart';

class EventChannelHandler {
   final EventChannel _wifiStream = const EventChannel("flutter_wifi_utils_events");
   StreamSubscription? _wifiStreamSubscription;
   List<ScanResults> _scanResults = [];
   bool _isScanning = false;
   get wifiStream{
     return _wifiStream;
   }



   void startWifiScan({required Function onReceive}){
      if(!_isScanning){
        _isScanning = true;
        _wifiStreamSubscription = _wifiStream.receiveBroadcastStream().listen((value)=>{
          _isScanning = false,
          _scanResults = _convertScanResults(value),
          onReceive(_scanResults)
      });
      }
   }

   void cancelWiFiScan(){
     if(_isScanning){
      try{
      _wifiStreamSubscription!.cancel();
     }catch(e){
      print(e);
     }
     }
   }

   get scanResults {
      return _scanResults;
   }

   List<ScanResults> _convertScanResults(List<Object?> scans){
      List<ScanResults> _results = [];
      for (var i in scans){
         var json = jsonDecode(i.toString());
         _results.add(ScanResults(
             SSID: json["SSID"],
             BSSID: json["BSSID"],
             level: json["level"],
             frequency: json["frequency"],
             timestamp: json["timestamp"],
             passpoint: json["passpoint"],
             channelBandwidth: json["channelBandwidth"],
             centerFreq0: json["centerFreq0"],
             centerFreq1: json["centerFreq1"],
             standard: json["standard"]
         ));
      }
      return _results;
   }



}