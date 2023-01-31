package fun.etrigan.flutter_wifi_utils.WiFi;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.util.Log;

import java.util.List;

import io.flutter.plugin.common.EventChannel;

public class ScanWiFi implements  EventChannel.StreamHandler{
    private BroadcastReceiver   wifiScanReceiver;
    private Context context;
    private WifiManager wifiManager;
    public ScanWiFi(Context _context){
        context = _context;
    }

    private void scanSuccess(){
        List<ScanResult> results = wifiManager.getScanResults();
        for (ScanResult s : results){
            Log.d("ScanResult: ", s.toString());
        }
    }

    private void scanFailure(){
        //Uses old scan result
        List<ScanResult> results = wifiManager.getScanResults();
        for (ScanResult s : results){
            Log.d("ScanResult: ", s.toString());
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
        wifiScanReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                boolean success = intent.getBooleanExtra(WifiManager.EXTRA_RESULTS_UPDATED, false);
                if(success){
                    scanSuccess();
                } else {
                    scanFailure();
                }
            }
        };
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION);
        context.registerReceiver(wifiScanReceiver, intentFilter);
        boolean success = wifiManager.startScan();
        if(!success){
            scanFailure();
        }
    }

    @Override
    public void onCancel(Object arguments) {
        wifiScanReceiver.abortBroadcast();
    }
}
