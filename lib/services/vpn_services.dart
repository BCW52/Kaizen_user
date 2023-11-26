import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/model/server_model.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

class VpnServicesMethods {
  Future<String> prepareVpn() async {
    return await platform.invokeMethod(VpnConstants.prepareVpn).then((value) {
      return value;
    }).catchError((e) {
      toast(e.toString());
      return "Not Connected";
    });
  }

  var httpClient = HttpClient();

  Future<File> _downloadFile({required String url, required String filename}) async {
    String dir = (await (getApplicationDocumentsDirectory())).path;
    File file = File('$dir/$filename.ovpn');

    if (file.existsSync()) {
      return file;
    } else {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);

      file.writeAsBytesSync(bytes, flush: true);

      return file;
    }
  }

  Future<bool> startVpn({required ServerModel server}) async {
    File data = await _downloadFile(url: server.ovpn!, filename: server.country!);

    server.content = data.readAsStringSync();
    log(server.toJson());
    return await platform.invokeMethod(VpnConstants.startVpn, server.toJson()).then((value) {
      return value;
    }).catchError((e) {
      toast(e.toString());
      return false;
    });
  }

  Future<void> updateVpn({required ServerModel server}) async {
    File data = await _downloadFile(url: server.ovpn!, filename: server.country!);

    server.content = data.readAsStringSync();
    log(server.toJson());

    await platform.invokeMethod(VpnConstants.updateVpn, server.toJson()).then((value) {
      log('Vpn Changed successfully');
    }).catchError((e) {
      log(e.toString());
    });
  }

  Future<String> getVPNStatus() async {
    return await platform.invokeMethod('getStatus').then((value) {
      log('Status $value');
      return value;
    }).catchError((e) {
      throw e.toString();
    });
  }

  Future<void> stopVpn() async {
    await platform.invokeMethod(VpnConstants.stopVpn).then((value) {
      log('Stopped');
    }).catchError((e) {
      log(e.toString());
    });
  }
}
