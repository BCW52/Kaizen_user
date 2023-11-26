import UIKit
import Flutter
import NetworkExtension

var providerManager: NETunnelProviderManager!
var timer = Timer()
var eventSink: FlutterEventSink?
var vpnStageSink: FlutterEventSink?

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
   
    var preferences = UserDefaults()
    var dicSelectedServer = NSMutableDictionary();
    private static var utils : VPNUtils!;

    var methodChannel = "test_activity";
    var getStatus = "getStatus";
    var prepareVpn = "prepareVpn";
    var updateVpn = "updateVpn";
    var stopVpn = "stopVpn";
    var startVpn = "startVpn";
    var fromServer = "fromServer";
    var EVENT_CHANNEL_VPN_STAGE = "com.mighty.vpn/vpnStage";
    var VPN_SPEED_DATA = "com.mighty.vpn/vpnData";


    var providerManager: NETunnelProviderManager!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    setMethodChannel()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
        
    func setMethodChannel () {
        guard let controller: FlutterViewController = window?.rootViewController as? FlutterViewController else {
            fatalError("Invalid root view controller")
        }
        let methodChannel = FlutterMethodChannel(name: methodChannel, binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler({ [self](call: FlutterMethodCall, result: FlutterResult) -> Void in
        print("Call Method",call.method)
        
        AppDelegate.utils = VPNUtils();
    
        switch call.method {
            case self.fromServer:
                 self.formServer(call: call, result: result)
                 break
            case self.getStatus:
                 self.getStatus(call: call, result: result)
                 break
            case self.startVpn:
                 self.startVpn(call: call, result: result)
                 break
            case self.prepareVpn:
                 self.prepareVpn(call: call, result: result)
                 break
            case self.updateVpn:
                 self.updateVpn(call: call, result: result)
                 break
            case self.stopVpn:
                 self.stopVpn(call: call, result: result)
                 break
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
    }
    func getSelectedServer() {
        print("selected the server : ",self.preferences.string(forKey: "flutter.selectedServer") ?? "")
    }
    
    func formServer(call: FlutterMethodCall, result: FlutterResult) {
        result("Working")
    }
 
    func getStatus(call: FlutterMethodCall, result: FlutterResult){
        result("Get Status Method in iOS")
    }

    func prepareVpn(call: FlutterMethodCall, result: FlutterResult){
//         print("Prepare VPN")
        self.startVpn(call: call, result: result)
    }

    func updateVpn(call: FlutterMethodCall, result: FlutterResult){
        result("Updated VPN in iOS")
    }

    func stopVpn(call: FlutterMethodCall, result: FlutterResult) {
        AppDelegate.utils.stopVPN();
        result(true)
    }

    func startVpn(call: FlutterMethodCall, result: FlutterResult) {
          
        guard let ovpn: String = (call.arguments as? [String: Any])?["content"] as? String else {return}
        guard let userName: String = (call.arguments as? [String: Any])?["userName"] as? String else {return}
        guard let password: String = (call.arguments as? [String: Any])?["password"] as? String else {return}
        
        AppDelegate.utils.loadProviderManager(completion: { (success : Error?) -> Void in
            AppDelegate.utils.configureVPN(ovpnFileContent: ovpn, expireAt: "", user: userName, pass: password, completion: { (success : Error?) -> Void in
                
             if success == nil {
//                 print("Nil");
             } else {
                print("Success",success.debugDescription)
             }
            });
        });
        result(true);
    }   
}
