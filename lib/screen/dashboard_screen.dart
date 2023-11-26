import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/component/AdmobComponent.dart';
import 'package:mightyvpn/component/FacebookComponent.dart';
import 'package:mightyvpn/component/bandwidth_component.dart';
import 'package:mightyvpn/component/duration_component.dart';
import 'package:mightyvpn/component/ip_component.dart';
import 'package:mightyvpn/component/status_component.dart';
import 'package:mightyvpn/component/vpn_component.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/screen/server_list_screen.dart';
import 'package:mightyvpn/utils/AdConfigurationConstants.dart';
import 'package:mightyvpn/utils/cached_network_image.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:mightyvpn/utils/common.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:mightyvpn/utils/enums.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  InterstitialAd? myInterstitial;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    initializeStream();
    if (enableAdType == admob) {
      loadInterstitialAd();
    } else {
      loadFaceBookInterstitialAd();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    stageStream.cancel();
    myInterstitial!.dispose();
    dataStream.cancel();
    super.dispose();
  }

  void startVPN() {
    appStore.setLoading(true);
    vpnServicesMethods.startVpn(server: appStore.mSelectedServerModel).then((value) {
      initializeStream();
    }).catchError((e) {
      toast(e.toString(), print: true);
    });
  }

  void prepareVPN() {
    vpnServicesMethods.prepareVpn().then(
      (value) {
        log(value);
        if (value == "0") {
          toast("VPN Permission Denied");
          vpnStore.setIsPrepared(false, initialize: true);
        } else if (value == "-1") {
          toast("VPN Permission Granted");
          vpnStore.setIsPrepared(true, initialize: true);
        } else if (value == "1") {
          vpnStore.setIsPrepared(true, initialize: true);
          startVPN();
        }
      },
    ).catchError((e) {
      log(e.toString());
    });
  }

  Future<void> stopVpn() async {
    await vpnServicesMethods.stopVpn().then((value) {
      toast(language.lblDisconnect);
      if (enableAdType == admob) {
        showInterstitialAd();
      } else {
        showFacebookInterstitialAd();
      }
      appStore.setLoading(false);
    }).catchError((e) {
      toast(e.toString());
    });
    vpnStore.setVPNStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(AppConstant.appName, showBack: false, center: true, elevation: 0),
      body: ListView(
        children: [
          16.height,
          IpComponent(),
          66.height,
          Observer(
            builder: (_) {
              return VpnComponent(
                vpnStatus: vpnStore.vpnStatus == VPNStatus.connected,
                onStartTapped: () async {
                  HapticFeedback.heavyImpact();
                  if (vpnStore.vpnStatus == VPNStatus.disconnected) {
                    if (!vpnStore.mIsPrepared) {
                      prepareVPN();
                    } else {
                      startVPN();
                    }
                  } else {
                    stopVpn();
                  }
                },
                onTapped: () {
                  showConfirmDialogCustom(
                    context,
                    dialogType: DialogType.DELETE,
                    dialogAnimation: DialogAnimation.SCALE,
                    positiveText: language.lblDisconnect,
                    title: language.lblWouldYouLikeToCancelTheCurrentVPNConnection,
                    onAccept: (c) async {
                      HapticFeedback.heavyImpact();
                      await stopVpn();
                    },
                  );
                },
              );
            },
          ),
          60.height,
          Observer(builder: (_) => Loader().visible(appStore.isLoading)),
          16.height,
          StatusComponent(),
          8.height,
          DurationComponent(),
          36.height,
          BandwidthComponent(),
          60.height,
          Align(alignment: Alignment.bottomLeft, child: Text(language.lblCurrentServer, style: boldTextStyle())).paddingSymmetric(horizontal: 26),
          8.height,
          Observer(
            builder: (_) => SettingItemWidget(
              radius: radius(),
              decoration: boxDecorationDefault(borderRadius: radius(), color: context.cardColor, boxShadow: defaultBoxShadow(blurRadius: 0, spreadRadius: 0)),
              title: appStore.mSelectedServerModel.country.validate(),
              titleTextStyle: boldTextStyle(color: primaryColor),
              leading: cachedImage(appStore.mSelectedServerModel.flagUrl.validate(value: 'assets/images/vpn_logo.png'), width: 34, height: 34),
              onTap: () {
                push(ServerListScreen(), pageRouteAnimation: PageRouteAnimation.SlideBottomTop, duration: 250.milliseconds);
              },
            ).paddingSymmetric(horizontal: 26),
          ),
          16.height,
        ],
      ),
    );
  }
}
