/*
class ServerModel {
  String? country;
  String? flagUrl;
  String? ovpn;
  String? ovpnUserName;
  String? ovpnUserPassword;
  String? content;

  ServerModel({this.country, this.flagUrl, this.ovpn, this.ovpnUserName, this.ovpnUserPassword, this.content});

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      country: json['country'],
      flagUrl: json['flagUrl'],
      ovpn: json['ovpn'],
      ovpnUserName: json['ovpnUserName'],
      ovpnUserPassword: json['ovpnUserPassword'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = country;
    data['flagUrl'] = flagUrl;
    data['ovpn'] = ovpn;
    data['ovpnUserName'] = ovpnUserName;
    data['ovpnUserPassword'] = ovpnUserPassword;
    data['content'] = content;
    return data;
  }

  static List<ServerModel> getServerList() {
    List<ServerModel> list = [];
    list.add(
      ServerModel(country: 'Japan', ovpn: 'japan', ovpnUserName: 'vpn', ovpnUserPassword: 'vpn', flagUrl: LanguageImages.icJapanese),
    );
    list.add(
      ServerModel(country: 'Korea', ovpn: 'korea', ovpnUserName: 'vpn', ovpnUserPassword: 'vpn', flagUrl: LanguageImages.icKorean),
    );
    list.add(
      ServerModel(country: 'Vietnam', ovpn: 'vietnam', ovpnUserName: 'vpn', ovpnUserPassword: 'vpn', flagUrl: LanguageImages.icVietnamese),
    );
    return list;
  }
}
*/

class ServerKey {
  String uid = "uid";
  String name = "name";
  String flag = "flag";
  String ovpnFile = "ovpnFile";
  String userName = "userName";
  String ovpnBytes = "ovpnBytes";
  String password = "password";
  String isActive = "isActive";
  String content = "content";
  String createdAt = "createdAt";
  String updatedAt = "updatedAt";
  String isPremium = "isPremium";
}

ServerKey serverKey = ServerKey();

class ServerModel {
  String? flagUrl;
  bool? isActive;
  String? country;
  String? ovpn;
  String? ovpnUserName;
  String? uid;
  String? ovpnUserPassword;
  String? content;
  bool? isPremium;

  ServerModel({
    this.flagUrl,
    this.isActive,
    this.country,
    this.ovpn,
    this.ovpnUserName,
    this.uid,
    this.ovpnUserPassword,
    this.content,
    this.isPremium,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      flagUrl: json[serverKey.flag],
      isActive: json[serverKey.isActive],
      country: json[serverKey.name],
      ovpn: json[serverKey.ovpnFile],
      ovpnUserPassword: json[serverKey.password],
      uid: json[serverKey.uid],
      ovpnUserName: json[serverKey.userName],
      content: json[serverKey.content],
      isPremium: json[serverKey.isPremium],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[serverKey.flag] = flagUrl;
    data[serverKey.isActive] = isActive;
    data[serverKey.name] = country;
    data[serverKey.ovpnFile] = ovpn;
    data[serverKey.password] = ovpnUserPassword;
    data[serverKey.uid] = uid;
    data[serverKey.userName] = ovpnUserName;
    data[serverKey.content] = content;
    data[serverKey.isPremium] = isPremium;
    return data;
  }
}
