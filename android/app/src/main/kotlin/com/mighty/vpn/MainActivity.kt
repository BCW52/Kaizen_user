package com.mighty.vpn

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.VpnService
import android.os.Bundle
import android.os.RemoteException
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import de.blinkt.openvpn.OpenVpnApi
import de.blinkt.openvpn.core.OpenVPNService
import de.blinkt.openvpn.core.OpenVPNThread
import de.blinkt.openvpn.core.VpnStatus
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "vpn_channel"

    private var vpnStageSink: EventSink? = null
    private var vpnData: EventSink? = null


    private val EVENT_CHANNEL_VPN_STAGE = "com.mighty.vpn/vpnStage"
    private val VPN_SPEED_DATA = "com.mighty.vpn/vpnData"

    var mResult: MethodChannel.Result? = null

    private var localJson: JSONObject? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        isServiceRunning
        VpnStatus.initLogCache(this.cacheDir)
        LocalBroadcastManager.getInstance(this).registerReceiver(object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                try {
                    if (vpnStageSink != null) {
                        vpnStageSink!!.success(OpenVPNService.getStatus())
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
                try {
                    var duration = intent.getStringExtra("duration")
                    var lastPacketReceive = intent.getStringExtra("lastPacketReceive")
                    var byteIn = intent.getStringExtra("byteIn")
                    var byteOut = intent.getStringExtra("byteOut")
                    if (duration == null) duration = "00:00:00"
                    if (lastPacketReceive == null) lastPacketReceive = "0"
                    if (byteIn == null) byteIn = " "
                    if (byteOut == null) byteOut = " "
                    val jsonObject = JSONObject()
                    jsonObject.put("duration", duration)
                    jsonObject.put("last_packet_receive", lastPacketReceive)
                    jsonObject.put("byte_in", byteIn)
                    jsonObject.put("byte_out", byteOut)

                    localJson = jsonObject

                    if (vpnData != null) {
                        vpnData!!.success(jsonObject.toString())
                    }

                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }, IntentFilter("connectionState"))
        super.onCreate(savedInstanceState)


    }


    private val isServiceRunning: Unit
        get() {
            if (vpnStageSink != null) {
                vpnStageSink!!.success(OpenVPNService.getStatus())
            }
        }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL_VPN_STAGE).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventSink) {
                    vpnStageSink = events
                }

                override fun onCancel(arguments: Any?) {
                    vpnStageSink!!.endOfStream()
                }

            },
        )


        EventChannel(flutterEngine.dartExecutor.binaryMessenger, VPN_SPEED_DATA).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventSink) {
                    vpnData = events
                }

                override fun onCancel(arguments: Any?) {
                    vpnData!!.endOfStream()
                }
            },
        )


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            mResult = result;
            when {
                call.method.equals("prepareVpn") -> prepareVpn()

                call.method.equals("startVpn") -> startVpn(call, result)

                call.method.equals("stopVpn") -> stopVpn()

                call.method.equals("getStatus") -> result.success(OpenVPNService.getStatus())

                call.method.equals("updateVpn") -> updateVpn(call, result)
            }
        }

        super.configureFlutterEngine(flutterEngine)

    }


    private fun prepareVpn() {

        val intent = VpnService.prepare(context)

        if (intent != null) {
            startActivityForResult(intent, 1)
        } else {
            mResult?.success("1")
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        mResult?.success(resultCode.toString());
    }

    private fun updateVpn(call: MethodCall, result: MethodChannel.Result) {
        if (OpenVPNService.getStatus() == "CONNECTED") {
            stopVpn()
        }
        prepareVpn()
    }

    private fun startVpn(call: MethodCall, result: MethodChannel.Result) {
        val config: String = call.argument<String>("content").toString()
        val country: String = call.argument<String>("name").toString()
        val ovpnUserName: String = call.argument<String>("ovpnUserName").toString()
        val ovpnUserPassword: String = call.argument<String>("ovpnUserPassword").toString()

        try {

            OpenVpnApi.startVpn(context, config, country, ovpnUserName, ovpnUserPassword)
            if (vpnStageSink != null) {
                vpnStageSink!!.success("Connecting")
            }
            result.success(true)
        } catch (e: IOException) {
            e.printStackTrace()
            result.error("IO", e.toString(), e.message)
        } catch (e: RemoteException) {
            e.printStackTrace()
            result.error("Remote", e.toString(), e.message)
        } catch (e: NullPointerException) {
            e.printStackTrace()
            result.error("NullPointer", e.toString(), e.message)
        }

    }

    private fun stopVpn() {
        OpenVPNThread.stop()
        mResult?.success("Disconnected");
    }

}
