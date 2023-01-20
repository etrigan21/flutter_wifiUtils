import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wifi_utils/flutter_wifi_utils.dart';
import 'package:flutter_wifi_utils/flutter_wifi_utils_platform_interface.dart';
import 'package:flutter_wifi_utils/flutter_wifi_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterWifiUtilsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterWifiUtilsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterWifiUtilsPlatform initialPlatform = FlutterWifiUtilsPlatform.instance;

  test('$MethodChannelFlutterWifiUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterWifiUtils>());
  });

  test('getPlatformVersion', () async {
    FlutterWifiUtils flutterWifiUtilsPlugin = FlutterWifiUtils();
    MockFlutterWifiUtilsPlatform fakePlatform = MockFlutterWifiUtilsPlatform();
    FlutterWifiUtilsPlatform.instance = fakePlatform;

    expect(await flutterWifiUtilsPlugin.getPlatformVersion(), '42');
  });
}
