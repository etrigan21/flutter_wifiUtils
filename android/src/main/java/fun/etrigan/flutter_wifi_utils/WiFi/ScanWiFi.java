package fun.etrigan.flutter_wifi_utils.WiFi;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;

import fun.etrigan.flutter_wifi_utils.helpers.Helper;
import io.flutter.plugin.common.EventChannel;

public class ScanWiFi implements  EventChannel.StreamHandler{
    private BroadcastReceiver   wifiScanReceiver;
    private Context context;
    private WifiManager wifiManager;
    public ScanWiFi(Context _context){
        context = _context;
    }
    Helper helper = new Helper();
    private EventChannel.EventSink eventSink;
    private void scanSuccess() throws JSONException {
        List<ScanResult> results = wifiManager.getScanResults();
        ArrayList<String> jsonifiedScanResults = new ArrayList<String>();
        for (ScanResult s : results){
            jsonifiedScanResults.add(helper.convertScanResultToJSON(s).toString());
        }
        eventSink.success(jsonifiedScanResults);
    }

    private void scanFailure() throws JSONException {
        //Uses old scan result
        ArrayList<String> jsonifiedScanResults = new ArrayList<String>();
        List<ScanResult> results = wifiManager.getScanResults();
        for (ScanResult s : results){
            jsonifiedScanResults.add(helper.convertScanResultToJSON(s).toString());
        }
        eventSink.success(jsonifiedScanResults.toString());
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
        wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
        wifiScanReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                boolean success = intent.getBooleanExtra(WifiManager.EXTRA_RESULTS_UPDATED, false);
                if(success){
                    try {
                        scanSuccess();
                    } catch (JSONException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    try {
                        scanFailure();
                    } catch (JSONException e) {
                        throw new RuntimeException(e);
                    }
                }
            }
        };
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION);
        context.registerReceiver(wifiScanReceiver, intentFilter);
        boolean success = wifiManager.startScan();
        if(!success){
            try {
                scanFailure();
            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
        wifiScanReceiver.abortBroadcast();
    }
}
