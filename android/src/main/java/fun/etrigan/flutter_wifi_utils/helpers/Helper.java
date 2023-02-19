package fun.etrigan.flutter_wifi_utils.helpers;

import android.net.wifi.ScanResult;
import android.os.Build;

import org.json.JSONException;
import org.json.JSONObject;

public class Helper {

    public JSONObject convertScanResultToJSON(ScanResult scanResult) throws JSONException {
        JSONObject jsonScanResult = new JSONObject();
        jsonScanResult.put("SSID", scanResult.SSID);
        jsonScanResult.put("BSSID", scanResult.BSSID);
        jsonScanResult.put("level", scanResult.level);
        jsonScanResult.put("frequency", scanResult.frequency);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            jsonScanResult.put("timestamp", scanResult.timestamp);

        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            jsonScanResult.put("passpoint", scanResult.isPasspointNetwork());
            jsonScanResult.put("channelBandWidth", scanResult.channelWidth);
            jsonScanResult.put("centerFreq0", scanResult.centerFreq0);
            jsonScanResult.put("centerFreq1", scanResult.centerFreq1);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            jsonScanResult.put("standard", scanResult.getWifiStandard());
        }
        return jsonScanResult;
    }
}

//standard: 11ac, 80211mcResponder: is not supported, Radio Chain Infos: [RadioChainInfo: id=0, level=-84], interface name: wlan0