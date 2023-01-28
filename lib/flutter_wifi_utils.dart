
import 'flutter_wifi_utils_platform_interface.dart';

class FlutterWifiUtils {
  Future<String?> getPlatformVersion() {
    return FlutterWifiUtilsPlatform.instance.getPlatformVersion();
  }

  Future<bool?> enableWiFi()async{
    return await FlutterWifiUtilsPlatform.instance.enableWiFi();
  }

  Future<void> disableWiFi() async {
    await FlutterWifiUtilsPlatform.instance.disableWiFi();
  }

  Future<bool> connectToWiFi({required String SSID, required String password, int timeout = 40000}) async {
    return await FlutterWifiUtilsPlatform.instance.connectToWiFi(
      SSID: SSID,
      password: password,
      timeout: timeout
    );
  }


}
