import 'package:flutter/material.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/screen/dashboard_screen.dart';
import 'package:mightyvpn/screen/internet_speed_screen.dart';
import 'package:mightyvpn/screen/settings_screen.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> vpnTabs = [];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    vpnTabs.add( DashboardScreen());
    vpnTabs.add( InternetSpeedTestScreen());
    vpnTabs.add( SettingsScreen());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: vpnTabs,
        index: selectedIndex
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) {
          selectedIndex = i;
          setState(() {});
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: primaryColor.withOpacity(0.55),
        items: [
          BottomNavigationBarItem(
            icon:  Icon(Icons.vpn_key_outlined),
            label: '',
            tooltip: language.lblVPNConnect,
            activeIcon: Container(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: radius()),
              child:  Icon(Icons.vpn_key_outlined),
            ),
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.speed_outlined),
            label: '',
            tooltip: language.lblInternetSpeed,
            activeIcon: Container(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: radius()),
              child:  Icon(Icons.speed_outlined),
            ),
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.settings_outlined),
            label: '',
            tooltip: language.lblSetting,
            activeIcon: Container(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: radius()),
              child:  Icon(Icons.settings_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
