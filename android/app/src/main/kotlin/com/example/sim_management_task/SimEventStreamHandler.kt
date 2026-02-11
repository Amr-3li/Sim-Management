package com.example.sim_management_task

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.plugin.common.EventChannel

class SimEventStreamHandler(
    private val context: Context
) : EventChannel.StreamHandler {

    private var eventSink: EventChannel.EventSink? = null
    private var isRegistered = false

    private val simReceiver = object : BroadcastReceiver() {
        override fun onReceive(ctx: Context?, intent: Intent?) {
            val action = intent?.action ?: return

            if (
                action == "android.intent.action.SIM_STATE_CHANGED" ||
                action == "android.telephony.action.SIM_CARD_STATE_CHANGED" ||
                action == "android.telephony.action.SIM_APPLICATION_STATE_CHANGED"
            ) {
                eventSink?.success("SIM_CHANGED")
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events

        if (!isRegistered) {
            val filter = IntentFilter().apply {
                addAction("android.intent.action.SIM_STATE_CHANGED")
                addAction("android.telephony.action.SIM_CARD_STATE_CHANGED")
                addAction("android.telephony.action.SIM_APPLICATION_STATE_CHANGED")
            }
            context.registerReceiver(simReceiver, filter)
            isRegistered = true
        }
    }

    override fun onCancel(arguments: Any?) {
        if (isRegistered) {
            context.unregisterReceiver(simReceiver)
            isRegistered = false
        }
        eventSink = null
    }
}
