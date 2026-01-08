package com.example.sim_management_task

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class SimStateReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            "android.telephony.action.SIM_CARD_STATE_CHANGED",
            "android.telephony.action.SIM_APPLICATION_STATE_CHANGED" -> {
                SimEventStreamHandler.sendEvent()
            }
        }
    }
}
