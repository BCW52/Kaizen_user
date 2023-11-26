import 'package:flutter/material.dart';
import 'package:mightyvpn/model/server_model.dart';
import 'package:nb_utils/nb_utils.dart';

class ServerComponent extends StatelessWidget {
  const ServerComponent({
    Key? key,
    required this.selected,
    required this.data,
    required this.onValueChanged,
  }) : super(key: key);

  final bool selected;
  final ServerModel data;
  final Function(ServerModel value) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithShadow(borderRadius: radius(), backgroundColor: selected ? context.primaryColor.withOpacity(0.2) : context.cardColor),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(data.flagUrl.validate(value: 'assets/images/vpn_logo.png'), width: 34, height: 34),
          Text(data.country.validate(), style: boldTextStyle()).expand(),
        ],
      ),
    ).onTap(() {
      onValueChanged.call(data);
    });
  }
}
