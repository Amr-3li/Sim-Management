package com.example.sim_management_task

import io.flutter.plugin.common.EventChannel

object SimEventStreamHandler : EventChannel.StreamHandler {

    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    fun sendEvent() {
        eventSink?.success("SIM_CHANGED")
    }
}
