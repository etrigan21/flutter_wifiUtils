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
}
