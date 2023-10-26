import 'package:flutter/material.dart';
import 'package:mightyvpn/component/circle_painter.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/colors.dart';
import 'package:mightyvpn/utils/enums.dart';
import 'package:nb_utils/nb_utils.dart';

class VpnComponent extends StatefulWidget {
  final bool vpnStatus;
  final Function()? onStartTapped;
  final Function()? onTapped;

  const VpnComponent({Key? key, this.vpnStatus = false, required this.onStartTapped, required this.onTapped}) : super(key: key);

  @override
  State<VpnComponent> createState() => _VpnComponentState();
}

class _VpnComponentState extends State<VpnComponent> with TickerProviderStateMixin {
  AnimationController? _circleRippleController;
  AnimationController? _controller;

  late double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _circleRippleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _circleRippleController?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  LinearGradient getConnectedGradient() {
    return LinearGradient(
      colors: List<Color>.generate(9, (index) => primaryColor.withOpacity(index / 100)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      _scale = 1 - (_controller?.value ?? 0.0);
    }

    if (widget.vpnStatus) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: GestureDetector(
            onTap: widget.onTapped,
            child: CustomPaint(
              painter: CirclePainter(_circleRippleController, color: primaryColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(defaultRadius),
                child: ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(parent: _circleRippleController!, curve: Curves.ease),
                  ),
                  child: Container(
                    width: context.width() * 0.45,
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: getConnectedGradient()),
                    child: const Icon(LineIcons.stop_circle, size: 86, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Listener(
      onPointerDown: (details) {
        _controller?.forward();
      },
      onPointerUp: (details) {
        _controller?.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: GestureDetector(
          onTap: widget.onStartTapped,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor.withOpacity(0.1)),
            child: Column(
              children: [
                const Icon(Icons.power_settings_new, size: 86, color: primaryColor),
                Text(getStatus(vpnStore.vpnStatus != VPNStatus.disconnected), style: boldTextStyle(color: primaryColor, size: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getStatus(bool val) {
    if (val) {
      return 'Stop';
    } else {
      return 'Start';
    }
  }
}
