import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_wifi_utils/flutter_wifi_utils.dart';
import 'package:permission_handler/permission_handler.dart';

bool connected = false;
String ssid = '';
void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isScanning = false;
  final _flutterWifiUtilsPlugin = FlutterWifiUtils();

  void getPermission()async{
    await Permission.location.request();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getPermission();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterWifiUtilsPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    _flutterWifiUtilsPlugin.toggleWiFi();
                  },
                  child: Text("toggle")
                ),
                ElevatedButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context) =>_wifiCredentials( utils: _flutterWifiUtilsPlugin, context: context)).then((value){
                      if(connected == true){
                        scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text("is Connected to $ssid")));
                      } else {
                        scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text("Failed to connect")));
                      }
                    });
                  },
                  child: Text("connect to WiFi")
                ),
                ElevatedButton(
                  onPressed: (){
                    _flutterWifiUtilsPlugin.disconnectAndRemoveWiFi(SSID: ssid).then((value){
                      print("eh");
                      scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text("disconnected")));
                    });
                  },
                  child: Text("Disconnect from current WiFi"),
                ),
                ElevatedButton(onPressed: (){
                  if(!_isScanning){
                    setState(() {
                    _isScanning = true;
                  });
                  _flutterWifiUtilsPlugin.startScan(onReceive: (value)=>{
                    print(value),
                  });
                  }
                }, child: Text("Start Scan")),
                ElevatedButton(onPressed: (){
                  if(_isScanning){
                    setState(() {
                    _isScanning = false;
                  });
                  _flutterWifiUtilsPlugin.stopScan();
                  }
                }, child: Text("Stop Scan")),

              ]
            )
          )
        ),
      );
  }
}

// Widget _scanResultsWiFi({required bool isScanning}){
//   return StreamBuilder(
//
//       builder: builder)
// }

Widget _wifiCredentials({required FlutterWifiUtils utils, required BuildContext context}){
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ssidController = TextEditingController();
  return AlertDialog(
    title: Text("Connect to WiFi"),
    content: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 250,
        maxWidth: 250
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _passwordController,
          ),
          TextField(
            controller: _ssidController,
          ),
          ElevatedButton(onPressed: (){
                if(_ssidController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                  utils.connectToWiFi(SSID: _ssidController.text, password: _passwordController.text).then((value){
                    connected = true;
                    ssid = _ssidController.text;
                    Navigator.of(context).pop();
                  }).catchError((err){
                    connected = false;
                    ssid = '';
                    Navigator.pop(context);});
                } else {
                  print("Cannot be empty");
                }
          }, child: Text("Connect")),

        ],
      ),
    )
  );
}

