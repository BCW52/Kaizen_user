import 'package:mightyvpn/model/server_model.dart';
import 'package:mightyvpn/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

const appName = 'Anonymous VPN';

const iconSize = 26.0;
const textSize = 16.0;


class AppConstant {
  static const appName = 'Mighty VPN';
  static const appDescription =
      'Surf the web anonymously and securely with Mighty VPN app template. If you are a web surfer, Mighty VPN is for you. For an uninterrupted, high speed browsing and zero logs, this app template allows online activity to be private. Facilitate lightning fast speed, Mighty VPN is compatible with PC, Mac, iOS, Android, Routers, and more. Protect your privacy, keeping you safe from third party tracking, unblock geographically restricted sites, one click to connect VPN, encrypt the internet traffic, and more with Mighty VPN app. Unblock and access streaming videos, movies, series, matches, shows, and more without buffering. The super fast Mighty VPN app is ideal for streaming games. You can also change your IP address to wherever you want with Mighty VPN app. With a set of resourceful features, Mighty VPN app comes with a modern functionalities';

  static const defaultLanguage = 'en';
  static ServerModel defaultServer = ServerModel(country: 'Japan', ovpn: 'japan', ovpnUserName: 'vpn', ovpnUserPassword: 'vpn', flagUrl: LanguageImages.icJapanese);
}

class AppThemeMode {
  static const themeModeSystem = 0;
  static const themeModeLight = 1;
  static const themeModeDark = 2;
}

class VpnConstants {
  //Native Event Name
  static const String eventStage = 'com.mighty.vpn/vpnStage';
  static const String eventData = 'com.mighty.vpn/vpnData';
  static const String methodChannelName = 'vpn_channel';

  // Native Method Name
  static const String prepareVpn = 'prepareVpn';
  static const String startVpn = 'startVpn';
  static const String updateVpn = 'updateVpn';
  static const String stopVpn = 'stopVpn';
  static const String fromServer = 'fromServer';

  static const String connecting = 'Connecting';
  static const String wait = 'Waiting for server reply';
  static const String auth = 'Authenticating';
  static const String getConfig = 'Getting client configuration';
  static const String assignIp = 'Assigning IP addresses';
  static const String addRoutes = 'Adding routes';
  static const String connected = 'Connected';
  static const String disconnected = 'Disconnect';
  static const String reconnecting = 'Reconnecting';
  static const String exiting = 'Exiting';
  static const String resolve = 'Not running';
  static const String tcpConnect = 'Resolving host names';
  static const String noNetwork = 'Not Connected to network';
  static const String connectRetry = 'Retrying';
  static const String authPending = 'Connecting (TCP)';
  static const String userPause = 'Connection paused';
  static const String notConnected = 'Not connected';
}

class SharedPrefKeys {
  static const selectedServer = 'selectedServer';
  static const vpnConnected = 'vpnConnected';
  static const vpnConnecting = 'vpnConnecting';
  static const vpnDisconnected = 'vpnDisconnected';
  static const vpnWaitConnection = 'vpnWaitConnection';
  static const language = 'language';
  static const isPrepared = 'isPrepared';
}

class Urls {
  static const appDescription = "";
  static String copyRight = 'copyright @${DateTime.now().year} ${AppConstant.appName}';
  static const packageName = "com.mighty.vpn";
  static const privacyPolicy = "PRIVACY_POLICY_URL";
  static const termsAndConditionURL = 'TERMS_CONDITION_URL';
  static const supportURL = 'https://mighty.desky.support/';
  static const appShareURL = '$playStoreBaseURL$packageName';
  static const mailto = '';
  static const purchaseUrl = 'https://codecanyon.net/user/meetmighty/portfolio?direction=desc&order_by=sortable_at&view=grid';
  static const documentation = 'https://meetmighty.com/codecanyon/document/mightyvpn/';
}
