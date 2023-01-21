package fun.etrigan.flutter_wifi_utils.WiFi;

import android.content.Context;

import com.thanosfisherman.wifiutils.WifiUtils;
import Flutter
public class WiFiCommands {
    public void enableWiFi(Context context, MethodChannel.Result result){
        WifiUtils.withContext(context).enableWifi((boolean success)->{
            if(success){
            } else {}
        });
    }
}
