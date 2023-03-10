
import 'flutter_wifi_utils_platform_interface.dart';
import 'flutter_wifi_utils_streams.dart';

EventChannelHandler eventChannelHandler = EventChannelHandler();

class FlutterWifiUtils {
  Future<String?> getPlatformVersion() {
    return FlutterWifiUtilsPlatform.instance.getPlatformVersion();
  }

  Future<bool?> toggleWiFi()async{
    return await FlutterWifiUtilsPlatform.instance.toggleWiFi();
  }


  Future<bool> connectToWiFi({required String SSID, required String password, int timeout = 40000}) async {
    return await FlutterWifiUtilsPlatform.instance.connectToWiFi(
      SSID: SSID,
      password: password,
      timeout: timeout
    );
  }

  Future<bool> disconnectAndRemoveWiFi({required String SSID})async{
    return await FlutterWifiUtilsPlatform.instance.disconnectAndRemove(SSID: SSID);
  }

  void startScan({required Function onReceive}){
    eventChannelHandler.startWifiScan(onReceive: onReceive);
  }

  void stopScan(){
    eventChannelHandler.cancelWiFiScan();
  }

  get scanResults {
    eventChannelHandler.scanResults;
  }
}
