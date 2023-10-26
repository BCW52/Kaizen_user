import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/screen/about_screen.dart';
import 'package:mightyvpn/screen/language_screen.dart';
import 'package:mightyvpn/screen/theme_screen.dart';
import 'package:mightyvpn/utils/common.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    packageInfo = await PackageInfo.fromPlatform().catchError((e) {
      toast(e.toString());
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget trailingIcon({bool? isVersion}) {
    return const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language.lblSetting, showBack: false, center: true, elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          SettingItemWidget(
            leading: Icon(FontAwesome.language, color: context.iconColor, size: 20),
            title: language.lblChangeLanguage,
            trailing: Row(
              children: [
                8.width,
                Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
              ],
            ),
            onTap: () {
              push(LanguageScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
            },
          ),
          Observer(
            builder: (_) => SettingItemWidget(
              title: language.lblTheme,
              leading: Icon(!appStore.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, size: 20),
              onTap: () {
                push(ThemeScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
              },
              trailing: trailingIcon(),
            ),
          ),
          SettingItemWidget(
            title: language.lblPrivacyLolicy,
            leading: Icon(Icons.privacy_tip_outlined, size: 20),
            trailing: trailingIcon(),
            onTap: () {
              AppCommon.launchURL(Urls.privacyPolicy);
            },
          ),
          SettingItemWidget(
            leading: Icon(Icons.rate_review_outlined, size: 20),
            title: language.lblRateLs,
            onTap: () {
              AppCommon.launchURL("$playStoreBaseURL${packageInfo?.packageName}");
            },
            trailing: trailingIcon(),
          ),
          SettingItemWidget(
            leading: Icon(LineIcons.file, size: 20),
            title: language.lblTermsAndConditions,
            onTap: () {
              AppCommon.launchURL(Urls.termsAndConditionURL);
            },
            trailing: trailingIcon(),
          ),
          SnapHelperWidget(
            future: PackageInfo.fromPlatform(),
            onSuccess: (data) {
              return SettingItemWidget(
                leading: Icon(Icons.share_outlined, size: 20),
                title: language.lblShareApp,
                onTap: () {
                  Share.share(
                    '${language.lblShare} ${AppConstant.appName} app\n\n${AppConstant.appDescription}\n\n$playStoreBaseURL${packageInfo?.packageName}',
                  );
                },
              );
            },
          ),
          SettingItemWidget(
            title: language.lblAboutUs,
            leading: Icon(Icons.perm_device_info, size: 20),
            onTap: () {
              AboutScreen().launch(context);
            },
            trailing: trailingIcon(),
          ),
          Spacer(),
          Text("V ${packageInfo?.version}", style: secondaryTextStyle(letterSpacing: 1.2, size: 16)).center(),
          26.height,
        ],
      ),
    );
  }
}
