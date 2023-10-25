import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:mightyvpn/utils/common.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  final String? id;

  AboutScreen({this.id});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language.lblAboutUs, color: context.scaffoldBackgroundColor),
      body: SnapHelperWidget<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        onSuccess: (data) => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppConstant.appName, style: boldTextStyle(size: 25)),
                16.height,
                 Divider(height: 16, thickness: 4, color: primaryColor, endIndent: 250),
                16.height,
                Text(language.lblVersion, style: boldTextStyle()),
                Text(data.version, style: primaryTextStyle()),
                8.height,
                Text(AppConstant.appDescription, style: secondaryTextStyle()),
                16.height,
                AppButton(
                  padding:  EdgeInsets.all(16),
                  color: appButtonColor,
                  elevation: 0,
                  onTap: () {
                    AppCommon.launchURL(Urls.purchaseUrl, forceWebView: true);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Icon(MaterialCommunityIcons.shopping_outline, color: primaryColor),
                      4.width,
                      Text(language.lblPurchase, style: boldTextStyle(color: primaryColor)),
                    ],
                  ),
                ),
                16.height,
                AppButton(
                  padding:  EdgeInsets.all(16),
                  color: appButtonColor,
                  elevation: 0,
                  onTap: () {
                    AppCommon.launchURL(Urls.documentation, forceWebView: true);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Icon(Icons.contact_page_outlined, color: primaryColor),
                      4.width,
                      Text(language.lblDocument, style: boldTextStyle(color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
