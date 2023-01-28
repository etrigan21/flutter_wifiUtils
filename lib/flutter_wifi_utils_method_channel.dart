import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_wifi_utils_platform_interface.dart';

/// An implementation of [FlutterWifiUtilsPlatform] that uses method channels.
class MethodChannelFlutterWifiUtils extends FlutterWifiUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_wifi_utils');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> enableWiFi()async{
    return await methodChannel.invokeMethod<bool>("enableWiFi");
  }
  @override
  Future<void> disableWiFi()async{
    await methodChannel.invokeMethod("disableWiFi");
  }
  @override
  Future<bool> connectToWiFi({required String SSID, required String password, int timeout = 40000})async{
    return await methodChannel.invokeMethod("connectToWiFi", {
      "SSID": SSID,
      "password": password,
      "timeout": timeout,
    });
  }

  @override
  Future<bool> connectToWiFiViaBSSIDAndSSID({required String SSID, required String BSSID, required String password, int timeout = 40000})async{
    return await methodChannel.invokeMethod("connectToWiFiViaBSSID", {
      "BSSID": BSSID,
      "SSID": SSID,
      "password": password,
      "timeout": timeout
    });
  }

  @override
  Future<bool> connectWithWPS({required String BSSID, required String password, int timeout = 40000})async{
    return await methodChannel.invokeMethod("connectViaWPS", {
      "BSSID": BSSID,
      "password": password,
      "timeout": timeout
    });
  }

  @override
  Future<bool> disconnectAndRemove({required String SSID})async{
    return await methodChannel.invokeMethod("disconnectAndRemove", {
      "SSID": SSID
    });
  }
}
