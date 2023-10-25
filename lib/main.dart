import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/app_theme.dart';
import 'package:mightyvpn/language/base_language.dart';
import 'package:mightyvpn/screen/splash_screen.dart';
import 'package:mightyvpn/services/server_services.dart';
import 'package:mightyvpn/services/vpn_services.dart';
import 'package:mightyvpn/store/appstore.dart';
import 'package:mightyvpn/store/vpnstore.dart';
import 'package:mightyvpn/utils/common.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'language/app_localizations.dart';

AppStore appStore = AppStore();
VpnStore vpnStore = VpnStore();

ServerService serverService = ServerService();

const MethodChannel platform = MethodChannel(VpnConstants.methodChannelName);
const EventChannel vpnData = EventChannel(VpnConstants.eventData);
const EventChannel vpnStage = EventChannel(VpnConstants.eventStage);

FirebaseFirestore fireStore = FirebaseFirestore.instance;

VpnServicesMethods vpnServicesMethods = VpnServicesMethods();
late StreamSubscription stageStream;
late StreamSubscription dataStream;

late BaseLanguage language;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  defaultRadius = 20.0;
  await initialize(aLocaleLanguageList: languageList());

  forceEnableDebug = true;

  await Firebase.initializeApp();
  MobileAds.instance.initialize();

  vpnStore.setIsPrepared(getBoolAsync(SharedPrefKeys.isPrepared));
  // appStore.setSelectedServerModel(ServerModel.fromJson(jsonDecode(getStringAsync(SharedPrefKeys.selectedServer))));
  vpnStore.setVPNStatus();
  if (!isWeb) {
    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == AppThemeMode.themeModeLight) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == AppThemeMode.themeModeDark) {
      appStore.setDarkMode(true);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    WidgetsBinding.instance.addObserver(this);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) {
      appStore.setConnectivityResult(event);
    });

    afterBuildCreated(() async {
      setOrientationPortrait();
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState appLifecycleState) async {
    super.didChangeAppLifecycleState(appLifecycleState);
    if (appLifecycleState == AppLifecycleState.detached || appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.inactive) {
      _connectivitySubscription.cancel();
      stageStream.cancel();
      dataStream.cancel();
    }

    if (appLifecycleState == AppLifecycleState.resumed) {
      _connectivitySubscription.resume();
      stageStream.resume();
      dataStream.resume();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        navigatorKey: navigatorKey,
        scrollBehavior: MyBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: const [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguage.validate(value: AppConstant.defaultLanguage)),
      ),
    );
  }
}

