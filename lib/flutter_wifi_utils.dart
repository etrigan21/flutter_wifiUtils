
import 'flutter_wifi_utils_platform_interface.dart';

class FlutterWifiUtils {
  Future<String?> getPlatformVersion() {
    return FlutterWifiUtilsPlatform.instance.getPlatformVersion();
  }
}
