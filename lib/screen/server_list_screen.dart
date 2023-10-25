import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/component/AdmobComponent.dart';
import 'package:mightyvpn/component/FacebookComponent.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/model/server_model.dart';
import 'package:mightyvpn/utils/AdConfigurationConstants.dart';
import 'package:mightyvpn/utils/cached_network_image.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ServerListScreen extends StatefulWidget {
  const ServerListScreen({Key? key}) : super(key: key);

  @override
  _ServerListScreenState createState() => _ServerListScreenState();
}

class _ServerListScreenState extends State<ServerListScreen> {
  int isSelected = -1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isSelected = vpnStore.serverList.indexWhere((element) => element.uid == appStore.mSelectedServerModel.uid);
    if (enableAdType == admob) {
      loadInterstitialAd();
    } else {
      loadFaceBookInterstitialAd();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language.lblServerList,
        backWidget: IconButton(
          onPressed: () {
            if (enableAdType == admob) {
              showInterstitialAd();
            } else {
              showFacebookInterstitialAd();
            }

            finish(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: context.iconColor),
        ),
        showBack: true,
        elevation: 0,
        center: true,
        actions: [
          IconButton(
            onPressed: () {
              if (vpnStore.serverList[isSelected].uid == appStore.mSelectedServerModel.uid) {
                toasty(
                  context,
                  language.lblSameServerSelected,
                  gravity: ToastGravity.TOP,
                  borderRadius: radius(),
                  bgColor: context.cardColor,
                  duration: 3.seconds,
                  textColor: textPrimaryColorGlobal,
                );
              } else {
                appStore.setSelectedServerModel(vpnStore.serverList[isSelected]);
                toasty(
                  context,
                  "${language.lblServerChangedTo} ${vpnStore.serverList[isSelected].country}, ${language.lblPleaseWaitWhileReconnecting} ",
                  gravity: ToastGravity.TOP,
                  borderRadius: radius(),
                  bgColor: context.cardColor,
                  duration: 3.seconds,
                  textColor: textPrimaryColorGlobal,
                );
                vpnServicesMethods.updateVpn(server: vpnStore.serverList[isSelected]);
              }
              finish(context);
            },
            icon: Icon(Icons.done, color: context.iconColor),
          )
        ],
      ),
      bottomNavigationBar: enableAdType == admob
          ? AdWidget(
              ad: BannerAd(
                  adUnitId: mAdMobBannerId,
                  size: AdSize.banner,
                  listener: BannerAdListener(onAdLoaded: (ad) {
                    //
                  }),
                  request: AdRequest())
                ..load(),
            )
          : FacebookBannerAd(
              placementId: faceBookBannerPlacementId,
              bannerSize: BannerSize.STANDARD,
              listener: (result, value) {
                print("Banner Ad: $result -->  $value");
              },
            ),
      body: Observer(
        builder: (_) => Container(
          padding: EdgeInsets.all(16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              vpnStore.serverList.length,
              (index) {
                ServerModel data = vpnStore.serverList[index];
                bool selected = isSelected == index;
                return SettingItemWidget(
                  title: data.country.validate(),
                  decoration: BoxDecoration(color: context.cardColor, borderRadius: radius()),
                  leading: cachedImage(data.flagUrl.validate(value: 'assets/images/vpn_logo.png'), width: 34, height: 34),
                  trailing: Row(
                    children: [
                      selected
                          ? Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle, border: Border.all(color: primaryColor)),
                              child: Icon(Icons.done, size: 16, color: primaryColor))
                          : Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(border: Border.all(color: primaryColor), shape: BoxShape.circle)),
                    ],
                  ),
                  onTap: () {
                    isSelected = index;
                    setState(() {});
                  },
                  radius: radius(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
