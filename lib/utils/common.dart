import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/model/vpn_status.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:mightyvpn/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCommon {
  static String getStages(String name) {
    switch (name) {
      case "CONNECTING":
        return getTranslateValues(VpnConstants.connecting);
      case "WAIT":
        return getTranslateValues(VpnConstants.wait);
      case "AUTH":
        return getTranslateValues(VpnConstants.auth);
      case "GET_CONFIG":
        return getTranslateValues(VpnConstants.getConfig);
      case "ASSIGN_IP":
        return getTranslateValues(VpnConstants.assignIp);
      case "ADD_ROUTES":
        return getTranslateValues(VpnConstants.addRoutes);
      case "CONNECTED":
        return getTranslateValues(VpnConstants.connected);
      case "DISCONNECTED":
        return getTranslateValues(VpnConstants.disconnected);
      case "RECONNECTING":
        return getTranslateValues(VpnConstants.reconnecting);
      case "EXITING":
        return getTranslateValues(VpnConstants.exiting);
      case "RESOLVE":
        return getTranslateValues(VpnConstants.resolve);
      case "TCP_CONNECT":
        return getTranslateValues(VpnConstants.tcpConnect);
      case "NONETWORK":
        return getTranslateValues(VpnConstants.noNetwork);
      case "CONNECTRETRY":
        return getTranslateValues(VpnConstants.connectRetry);
      case "AUTH_PENDING":
        return getTranslateValues(VpnConstants.authPending);
      case "USERPAUSE":
        return getTranslateValues(VpnConstants.userPause);
    }
    return getTranslateValues(VpnConstants.connecting);
  }

  static String getTranslateValues(String name) {
    switch (name) {
      case VpnConstants.connecting:
        return language.lblConnecting;

      case VpnConstants.wait:
        return language.lblWait;

      case VpnConstants.auth:
        return language.lblAuth;

      case VpnConstants.getConfig:
        return language.lblGetConfig;

      case VpnConstants.assignIp:
        return language.lblAssignIp;

      case VpnConstants.addRoutes:
        return language.lblAddRoutes;

      case VpnConstants.connected:
        return language.lblConnected;

      case VpnConstants.disconnected:
        return language.lblDisconnected;

      case VpnConstants.reconnecting:
        return language.lblReconnecting;

      case VpnConstants.exiting:
        return language.lblExiting;

      case VpnConstants.resolve:
        return language.lblResolve;

      case VpnConstants.tcpConnect:
        return language.lblTcpConnect;

      case VpnConstants.noNetwork:
        return language.lblNoNetwork;

      case VpnConstants.connectRetry:
        return language.lblConnectRetry;

      case VpnConstants.authPending:
        return language.lblAuthPending;

      case VpnConstants.userPause:
        return language.lblUserPause;

      case VpnConstants.notConnected:
        return language.lblNotConnected;
    }
    return language.lblConnecting;
  }

  static Future<void> launchURL(String url, {bool forceWebView = false}) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    // await launchUrl(url, forceWebView: forceWebView, enableJavaScript: true, statusBarBrightness: Brightness.light, webOnlyWindowName: "News").catchError((e) {
    //   toast('Invalid URL: $url');
    // });
  }
}

Widget commonCacheImageWidget(String? url, double height, {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Image.network(url!, height: height, width: width, fit: fit);
    }
  } else if (url.validate().isEmpty) {
    return placeholderWidget();
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit);
  }
}

Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();

Widget placeholderWidget() => CircleAvatar(child: const Icon(Icons.person, color: Colors.black), backgroundColor: Colors.grey.shade300);

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', subTitle: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: LanguageImages.icUs),
    LanguageDataModel(id: 2, name: 'Hindi', subTitle: 'हिंदी', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: LanguageImages.icIndia),
    LanguageDataModel(id: 3, name: 'Arabic', subTitle: 'عربي', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: LanguageImages.icAr),
  ];
}

void initializeStream() {
  stageStream = vpnStage.receiveBroadcastStream().listen(
    (event) {
      vpnStore.setVpnStage(AppCommon.getStages(event));
      vpnStore.setVPNStatus();
    },
  );

  dataStream = vpnData.receiveBroadcastStream().listen((event) {
    VpnStatus data = VpnStatus.fromJson(jsonDecode(event));

    vpnStore.setByteIn(data.byteIn.validate());
    vpnStore.setByteOut(data.byteOut.validate());
    vpnStore.setDuration(data.duration.validate());
    vpnStore.setLastPacketReceive(data.lastPacketReceive.validate());

    vpnStore.setVPNStatus();
    appStore.setLoading(false);
  });
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
