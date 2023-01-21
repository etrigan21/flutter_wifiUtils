package fun.etrigan.flutter_wifi_utils.WiFi;

import android.content.Context;
import android.net.wifi.ScanResult;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import com.thanosfisherman.wifiutils.WifiUtils;
import com.thanosfisherman.wifiutils.wifiConnect.ConnectionErrorCode;
import com.thanosfisherman.wifiutils.wifiConnect.ConnectionSuccessListener;
import com.thanosfisherman.wifiutils.wifiRemove.RemoveErrorCode;
import com.thanosfisherman.wifiutils.wifiRemove.RemoveSuccessListener;
import com.thanosfisherman.wifiutils.wifiWps.ConnectionWpsListener;

import java.lang.reflect.Method;
import java.util.List;

import io.flutter.plugin.common.MethodChannel;

//import Flutter
public class WiFiCommands {
    Boolean isScanAvailable = false;
    List<ScanResult> oldScanResults;
    public void enableWiFi(Context context, MethodChannel.Result result){
        WifiUtils.withContext(context).enableWifi((boolean success)->{
            result.success(success);
        });
    }

    public void disableWiFi(Context context){
        WifiUtils.withContext(context).disableWifi();
    }

    public Boolean getIsScanAvailable(){
        return isScanAvailable;
    }
    public void scanWiFi(Context context, MethodChannel.Result result){
        WifiUtils.withContext(context).scanWifi(
                (@NonNull List<ScanResult> scanRes) -> {
                    if(scanRes.isEmpty()){
                        Log.d("New", "false");

                    } else {
                        Log.d("New", "true");
                    }
                    List<ScanResult> values = scanRes;
                    for (ScanResult s : values){
                        Log.d("item", s.SSID);
                    }
                }
        ).start();
    }

    public void connectToWiFi(Context context, MethodChannel.Result result, String SSID, String Password, int timeout){
        WifiUtils.withContext(context)
                .connectWith(SSID, Password)
                .setTimeout(timeout)
                .onConnectionResult(new ConnectionSuccessListener() {
                    @Override
                    public void success() {
                        result.success(true);
                    }

                    @Override
                    public void failed(@NonNull ConnectionErrorCode errorCode) {
                        result.success(false);
                    }
                })
                .start();
    }

    public void connectToWiFiViaSSIDAndBSSID(Context context, MethodChannel.Result result,String SSID, String BSSID, String password, int timeout){
        WifiUtils.withContext(context)
                .connectWith(SSID, BSSID, password).setTimeout(timeout)
                .onConnectionResult(new ConnectionSuccessListener() {
                    @Override
                    public void success() {
                        result.success(true);
                    }

                    @Override
                    public void failed(@NonNull ConnectionErrorCode errorCode) {
                        result.success(false);
                    }
                })
                .start();
    }

    public void connectWithWPS(Context context , String BSSID, String password, MethodChannel.Result result, int timeout){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            WifiUtils.withContext(context).connectWithWps(BSSID, password).setWpsTimeout(timeout).onConnectionWpsResult(new ConnectionWpsListener() {
                @Override
                public void isSuccessful(boolean isSuccess) {
                    result.success(isSuccess);
                }
            }).start();
        } else {
            result.success(false);
        }
    }

    public void disconnectAndRemove(Context context, String SSID, MethodChannel.Result result){
        WifiUtils.withContext(context).remove(SSID, new RemoveSuccessListener() {
            @Override
            public void success() {
                result.success(true);
            }

            @Override
            public void failed(@NonNull RemoveErrorCode errorCode) {
                result.success(false);
            }
        });
    }
}
