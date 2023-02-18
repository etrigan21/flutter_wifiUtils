class ScanResults{
  ScanResults({required this.SSID, required this.BSSID, required this.level, required this.frequency, this.timestamp, this.passpoint, this.channelBandwidth, this.centerFreq0, this.centerFreq1, this.standard});
  String SSID;
  String BSSID;
  int level;
  int frequency;
  int? timestamp;
  bool? passpoint;
  int? channelBandwidth;
  int? centerFreq0;
  int? centerFreq1;
  int? standard;

  Map<String, dynamic> toJson(){
    return {
      "SSID" : SSID,
      "BSSID": BSSID,
      "level": level,
      "frequency": frequency,
      "timestamp": timestamp,
      "passpoint": passpoint,
      "channelBandwidth": channelBandwidth,
      "centerFreq0": centerFreq0,
      "centerFreq1": centerFreq1,
      "standard": standard
    };

  }

  @override
  String toString() {
    return toJson().toString();
  }
}
