import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/model/server_model.dart';
import 'package:mightyvpn/screen/bottom_nav_bar.dart';
import 'package:mightyvpn/utils/common.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:mightyvpn/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    afterBuildCreated(
      () {
        setStatusBarColor(context.scaffoldBackgroundColor);

        appStore.setLanguage(getStringAsync(SharedPrefKeys.language, defaultValue: AppConstant.defaultLanguage), context: context);
      },
    );
    animationController = AnimationController(vsync: this, duration: 1.seconds);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInQuad);
    animationController.forward();

    vpnStore.setVPNStatus();

    serverService.getServerList().listen((event) {
      vpnStore.serverList.clear();

      vpnStore.setServerList(event);

      if (getStringAsync(SharedPrefKeys.selectedServer).isEmpty) {
        appStore.setSelectedServerModel(event.first);
      } else {
        appStore.setSelectedServerModel(ServerModel.fromJson(jsonDecode(getStringAsync(SharedPrefKeys.selectedServer))));
      }
    });

    2.seconds.delay.then((value) => push( BottomNavBar(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(scale: animation, child: commonCacheImageWidget(vpnLogo, 120, width: 120, fit: BoxFit.cover)),
            16.height,
            Text(AppConstant.appName, style: primaryTextStyle(size: 24, weight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
