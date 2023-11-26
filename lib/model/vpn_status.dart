class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? duration;
  String? lastPacketReceive;

  VpnStatus({this.byteIn, this.byteOut, this.duration, this.lastPacketReceive});

  factory VpnStatus.fromJson(Map<String, dynamic> json) {
    return VpnStatus(
      byteIn: json['byte_in'],
      byteOut: json['byte_out'],
      duration: json['duration'],
      lastPacketReceive: json['last_packet_receive'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['byte_in'] = this.byteIn;
    data['byte_out'] = this.byteOut;
    data['duration'] = this.duration;
    data['last_packet_receive'] = this.lastPacketReceive;
    return data;
  }
}
