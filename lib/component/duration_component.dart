import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class DurationComponent extends StatelessWidget {
  const DurationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Text(
        vpnStore.mDuration.validate(value: '00:00:00'),
        style: boldTextStyle(size: 24, color: primaryColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
