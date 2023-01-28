package fun.etrigan.flutter_wifi_utils;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import fun.etrigan.flutter_wifi_utils.WiFi.WiFiCommands;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterWifiUtilsPlugin */
public class FlutterWifiUtilsPlugin implements FlutterPlugin, MethodCallHandler , ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  WiFiCommands wiFiCommands = new WiFiCommands();
  private MethodChannel channel;
  private Context applicationContext;
  private Activity applicationActivity;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_wifi_utils");
    channel.setMethodCallHandler(this);
    applicationContext = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("enableWiFi")){
      wiFiCommands.enableWiFi(applicationContext, applicationActivity);
    } else if(call.method.equals("disableWiFi")){
      wiFiCommands.disableWiFi(applicationContext);
    } else if (call.method.equals("connectToWiFi")){
      String SSID = call.argument("SSID");
      String password = call.argument("password");
      int timeout = call.argument("timeout");
      wiFiCommands.connectToWiFi(applicationContext, result, SSID, password, timeout);
    } else if (call.method.equals("connectToWiFiViaBSSID")){
      String SSID = call.argument("SSID");
      String password = call.argument("password");
      String BSSID = call.argument("BSSID");
      int timeout = call.argument("timeout");
      wiFiCommands.connectToWiFiViaSSIDAndBSSID(applicationContext, result, SSID, BSSID, password, timeout);
    }else if(call.method.equals("connectViaWPS")){
      String BSSID = call.argument("BSSID");
      String password = call.argument("password");
      int timeout = call.argument("timeout");
      wiFiCommands.connectWithWPS(applicationContext, BSSID, password, result, timeout);
    } else if (call.method.equals("disconnectAndRemove")){
      String SSID = call.argument("SSID");
      wiFiCommands.disconnectAndRemove(applicationContext, SSID, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    applicationContext = null;
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    applicationActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    applicationActivity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    applicationActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    applicationActivity = null;
  }
}
