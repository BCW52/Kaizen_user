import 'package:flutter/material.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class InternetComponent extends StatelessWidget {
  final double? rate;
  final IconData iconData;

  InternetComponent({this.rate, required this.iconData, Key? key}) : super(key: key);

  BoxDecoration itemDecoration() {
    return BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: radius());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: itemDecoration(),
            padding: const EdgeInsets.all(6),
            child: Icon(iconData, size: 20, color: primaryColor),
          ),
          16.width,
          RichTextWidget(
            list: [
              TextSpan(text: rate!.toStringAsFixed(2), style: boldTextStyle(size: 24, color: primaryColor)),
              TextSpan(text: " Mbps", style: secondaryTextStyle(size: 12)),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
