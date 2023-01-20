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
}
