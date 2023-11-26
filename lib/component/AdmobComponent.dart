import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/utils/AdMobUtils.dart';

RewardedAd? rewardedAd;
InterstitialAd? myInterstitial;

BannerAd buildBannerAd() {
  return BannerAd(
    adUnitId: getBannerAdUnitId()! ,
    size: AdSize.banner,
    listener: BannerAdListener(onAdLoaded: (ad) {
      //
    }),
    request: AdRequest(),
  );
}

Future<void> loadInterstitialAd() async {
  InterstitialAd.load(
    adUnitId: getInterstitialAdUnitId()! ,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        myInterstitial = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        myInterstitial = null;
      },
    ),
  );
}

Future<void> showInterstitialAd() async {
  if (myInterstitial == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  myInterstitial!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      loadInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
      loadInterstitialAd();
    },
  );
  myInterstitial!.show();
  myInterstitial = null;
}

