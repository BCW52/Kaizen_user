import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class BandwidthComponent extends StatelessWidget {
  const BandwidthComponent({Key? key}) : super(key: key);

  BoxDecoration itemDecoration() {
    return BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: radius());
  }

  Widget bandwidthSection({required String title, required String value, required IconData iconData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: itemDecoration(),
          padding: const EdgeInsets.all(6),
          child: Icon(iconData, size: 20, color: primaryColor),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: boldTextStyle(), textAlign: TextAlign.center),
            Text(value, style: secondaryTextStyle(), textAlign: TextAlign.center),
          ],
        ).flexible()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bandwidthSection(
              title: language.lblDownload,
              value: vpnStore.mByteIn,
              iconData: Icons.arrow_downward_outlined,
            ).expand(),
            8.width,
            bandwidthSection(
              title: language.lblUpload,
              value: vpnStore.mByteOut,
              iconData: Icons.arrow_upward_outlined,
            ).expand(),
          ],
        ),
      ),
    );
  }
}
