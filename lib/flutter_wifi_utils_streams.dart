import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_wifi_utils/ScanResult.model.dart';

class EventChannelHandler {
   final EventChannel _wifiStream = const EventChannel("flutter_wifi_utils_events");
   StreamSubscription? _wifiStreamSubscription;
   List<ScanResults> _scanResults = [];
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
      var scanRes = _convertScanResults(value);
      _scanResults  = scanRes;
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