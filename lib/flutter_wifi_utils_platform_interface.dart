import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'flutter_wifi_utils_method_channel.dart';

abstract class FlutterWifiUtilsPlatform extends PlatformInterface {
  /// Constructs a FlutterWifiUtilsPlatform.
  FlutterWifiUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWifiUtilsPlatform _instance = MethodChannelFlutterWifiUtils();

  /// The default instance of [FlutterWifiUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWifiUtils].
  static FlutterWifiUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWifiUtilsPlatform] when
  /// they register themselves.
  static set instance(FlutterWifiUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> enableWiFi(){
    throw UnimplementedError('enableWiFi() has not been implemented');
  }

  Future<void> disableWiFi(){
    throw UnimplementedError('disableWiFi() has not been implemented');
  }

  Future<bool> connectToWiFi({required String SSID, required String password, int timeout = 40000}){
    throw UnimplementedError('connectToWiFi() has not been implemented');
  }

  Future<bool> connectToWiFiViaBSSIDAndSSID({required String BSSID, required String SSID, required String password, int timeout = 40000}){
    throw UnimplementedError('connectToWiFiViaBSSIDAndSSID() has not been implemented');
  }

  Future<bool> connectWithWPS({required String BSSID, required String password, int timeout = 40000}){
    throw UnimplementedError('connectWithWPS() has not been implemented');
  }

  Future<bool> disconnectAndRemove({required String SSID}){
    throw UnimplementedError('disconnectAndRemove() has not been implemented');
  }
}
