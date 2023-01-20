import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wifi_utils/flutter_wifi_utils_method_channel.dart';

void main() {
  MethodChannelFlutterWifiUtils platform = MethodChannelFlutterWifiUtils();
  const MethodChannel channel = MethodChannel('flutter_wifi_utils');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
