import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:mightyvpn/component/internet_component.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:speed_test_dart/classes/server.dart';
import 'package:speed_test_dart/speed_test_dart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class InternetSpeedTestScreen extends StatefulWidget {
  @override
  _InternetSpeedTestScreenState createState() => _InternetSpeedTestScreenState();
}

class _InternetSpeedTestScreenState extends State<InternetSpeedTestScreen> {
  FlutterInternetSpeedTest internetSpeedTest = FlutterInternetSpeedTest();
  double downloadRate = 0;
  double uploadRate = 0;

  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  double downloadProgress = 0.0;
  double uploadProgress = 0.0;
  double displayRate = 0;
  String displayRateTxt = '0.0';
  double displayPer = 0;
  String unitText = 'Mb/s';

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;

  bool isTesting = false;

  String value = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setBestServers();
  }

  // void startDownloading() {
  //   internetSpeedTest.startTesting(
  //     onDone: (TestResult transferRate, TestResult unit) {
  //       setState(() {
  //         downloadRate = transferRate.transferRate;
  //         protectGauge(downloadRate);
  //         unitText = unit.unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
  //         downloadProgress = 100.0;
  //         displayPer = 100.0;
  //       });
  //       startUploading();
  //     },
  //     onProgress: (double percent, TestResult data) {
  //       value = "Downloading Speed";
  //       setState(() {
  //         downloadRate = percent;
  //         protectGauge(downloadRate);
  //         unitText = data.unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
  //         downloadProgress = percent;
  //         displayPer = percent;
  //       });
  //     },
  //     onError: (String errorMessage, String speedTestError) {
  //       toast(language.lblDownloadTestFailed);
  //       setState(() {
  //         value = language.lblStartTest;
  //         isTesting = false;
  //       });
  //     },
  //     fileSize: 1,
  //   );
  // }
  //
  // void startUploading() {
  //   internetSpeedTest.startTesting(
  //     onDone: (TestResult transferRate, TestResult unit) {
  //       setState(() {
  //         uploadRate = transferRate.transferRate;
  //         uploadRate = uploadRate * 10;
  //         protectGauge(uploadRate);
  //         unitText = unit.unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
  //         uploadProgress = 100.0;
  //         displayPer = 100.0;
  //         isTesting = false;
  //         value = "";
  //       });
  //     },
  //     onProgress: (double percent, TestResult data) {
  //       value = "Uploading Speed";
  //
  //       setState(() {
  //         uploadRate = data.transferRate;
  //         uploadRate = uploadRate * 10;
  //         protectGauge(uploadRate);
  //         unitText = data.unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
  //         uploadProgress = percent;
  //         displayPer = percent;
  //       });
  //     },
  //     onError: (String errorMessage, String speedTestError) {
  //       toast(language.lblUploadTestFailed);
  //       log(errorMessage.toString());
  //       setState(() {
  //         isTesting = false;
  //       });
  //     },
  //     fileSize: 1,
  //   );
  // }

  Future<void> setBestServers() async {
    final settings = await tester.getSettings();
    final servers = settings.servers;

    final _bestServersList = await tester.getBestServers(
      servers: servers,
    );

    setState(() {
      bestServersList = _bestServersList;
      readyToTest = true;
    });
  }

  Future<void> _testDownloadSpeed() async {
    setState(() {
      loadingDownload = true;
    });
    final _downloadRate =
    await tester.testDownloadSpeed(servers: bestServersList);
    setState(() {
      downloadRate = _downloadRate;
      loadingDownload = false;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void protectGauge(double rate) {
    if (rate > 100) {
      displayRateTxt = rate.toStringAsFixed(2);
    } else {
      displayRate = rate;
      displayRateTxt = displayRate.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language.lblInternetSpeedTest, showBack: false, center: true, elevation: 0),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          width: context.width(),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SfRadialGauge(
                title: GaugeTitle(text: ' ', textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    axisLabelStyle: GaugeTextStyle(color: primaryColor),
                    ranges: <GaugeRange>[
                      GaugeRange(startValue: 0, endValue: 30, color: primaryColor.withOpacity(0.7), startWidth: 10, endWidth: 10),
                      GaugeRange(startValue: 30, endValue: 60, color: primaryColor.withOpacity(0.7), startWidth: 10, endWidth: 10),
                      GaugeRange(startValue: 60, endValue: 100, color: primaryColor.withOpacity(0.7), startWidth: 10, endWidth: 10)
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: downloadRate, enableAnimation: true, needleColor: primaryColor, animationType: AnimationType.bounceOut),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: RichTextWidget(
                          list: [
                            TextSpan(text: downloadRate.toStringAsFixed(2), style: boldTextStyle(size: 24, color: primaryColor)),
                            TextSpan(text: " $unitText", style: secondaryTextStyle(size: 14)),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.6,
                      ),
                    ],
                  )
                ],
              ),
              AppButton(
                color: appButtonColor,
                elevation: 0,
                textColor: primaryColor,
                enabled: value.isEmpty,
                text: value.isEmpty ? language.lblStartTest : value,
                onTap: () {
                  if (!isTesting) {
                    isTesting = true;
                    downloadRate = 0;
                    uploadRate = 0;
                    setState(() {});
                    _testDownloadSpeed();
                  }
                },
              ),
              32.height,
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InternetComponent(rate: downloadRate, iconData: Icons.arrow_downward_outlined).expand(),
                  InternetComponent(rate: uploadRate, iconData: Icons.arrow_upward_outlined).expand(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
