package com.example.sim_management_task

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.TelephonyManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class MainActivity : FlutterFragmentActivity() {

    companion object {
        const val SIM_CHANNEL = "sim_state_events"
        const val SIM_DATA_CHANNEL = "sim_data_channel"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SIM_CHANNEL
        ).setStreamHandler(
            SimEventStreamHandler(applicationContext)
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SIM_DATA_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAllSimData" -> getAllSimData(result)
                "getPhoneNumber" -> getPhoneNumber(result)
                else -> result.notImplemented()
            }
        }
    }

    @Suppress("DEPRECATION", "UNCHECKED_CAST")
    private fun getAllSimData(result: Result) {
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_PHONE_STATE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            result.error("PERMISSION_DENIED", "READ_PHONE_STATE permission required", null)
            return
        }

        try {
            val simCardsList = mutableListOf<Map<String, Any>>()
            
            val subscriptionManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                try {
                    getSystemService(SubscriptionManager::class.java)
                } catch (e: Exception) {
                    null
                }
            } else {
                null
            }

            val subscriptionInfoList = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1 && subscriptionManager != null) {
                try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                        subscriptionManager.activeSubscriptionInfoList
                    } else {
                        @Suppress("DEPRECATION")
                        subscriptionManager.activeSubscriptionInfoList
                    }
                } catch (e: Exception) {
                    null
                }
            } else {
                null
            }

            if (subscriptionInfoList != null && subscriptionInfoList.isNotEmpty()) {
                for (subInfo in subscriptionInfoList) {
                    try {
                        val carrierName = try {
                            subInfo.carrierName?.toString() ?: ""
                        } catch (e: Exception) {
                            ""
                        }

                        val countryIso = try {
                            subInfo.countryIso?.toString() ?: ""
                        } catch (e: Exception) {
                            ""
                        }

                        val displayName = try {
                            subInfo.displayName?.toString() ?: ""
                        } catch (e: Exception) {
                            ""
                        }

                        // ✅ شيلنا defaultSubscriptionId
                        val number = try {
                            @Suppress("DEPRECATION")
                            subInfo.number ?: ""
                        } catch (e: Exception) {
                            ""
                        }

                        val mcc = try {
                            subInfo.mcc
                        } catch (e: Exception) {
                            0
                        }

                        val mnc = try {
                            subInfo.mnc
                        } catch (e: Exception) {
                            0
                        }

                        val iccId = try {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                                val method = SubscriptionInfo::class.java.getMethod("getIccId")
                                method.invoke(subInfo) as? String ?: ""
                            } else {
                                @Suppress("DEPRECATION")
                                subInfo.iccId ?: ""
                            }
                        } catch (e: Exception) {
                            ""
                        }

                        val isEmbedded = try {
                            Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && subInfo.isEmbedded
                        } catch (e: Exception) {
                            false
                        }

                        val subscriptionId = try {
                            subInfo.subscriptionId
                        } catch (e: Exception) {
                            -1
                        }

                        val simData = mapOf(
                            "carrierName" to carrierName,
                            "countryIso" to countryIso,
                            "iccId" to iccId,
                            "number" to number,
                            "displayName" to displayName,
                            "mcc" to mcc.toString(),
                            "mnc" to mnc.toString(),
                            "isEmbedded" to isEmbedded,
                            "subscriptionId" to subscriptionId
                        )
                        simCardsList.add(simData)
                    } catch (e: Exception) {
                        continue
                    }
                }
            }

            if (simCardsList.isEmpty()) {
                try {
                    val telephonyManager = getSystemService(TELEPHONY_SERVICE) as TelephonyManager
                    
                    // ✅ شيلنا defaultSubscriptionId من هنا برضه
                    val phoneNumber = try {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                            telephonyManager.line1Number
                        } else {
                            @Suppress("DEPRECATION")
                            telephonyManager.line1Number
                        }
                    } catch (e: Exception) {
                        ""
                    }

                    val simOperatorName = try {
                        telephonyManager.simOperatorName ?: ""
                    } catch (e: Exception) {
                        ""
                    }

                    val simCountryIso = try {
                        telephonyManager.simCountryIso ?: ""
                    } catch (e: Exception) {
                        ""
                    }

                    val simSerialNumber = try {
                        telephonyManager.simSerialNumber ?: ""
                    } catch (e: Exception) {
                        ""
                    }

                    val simOperator = try {
                        telephonyManager.simOperator ?: ""
                    } catch (e: Exception) {
                        ""
                    }

                    val mcc = if (simOperator.length >= 3) simOperator.substring(0, 3) else ""
                    val mnc = if (simOperator.length > 3) simOperator.substring(3) else ""

                    val simData = mapOf(
                        "carrierName" to simOperatorName,
                        "countryIso" to simCountryIso,
                        "iccId" to simSerialNumber,
                        "number" to phoneNumber,
                        "displayName" to simOperatorName,
                        "mcc" to mcc,
                        "mnc" to mnc,
                        "isEmbedded" to false,
                        "subscriptionId" to -1
                    )
                    simCardsList.add(simData)
                } catch (e: Exception) {
                    // فشل
                }
            }

            result.success(simCardsList)
            
        } catch (e: Exception) {
            result.error("ERROR", e.message ?: "Unknown error", null)
        }
    }

    private fun getPhoneNumber(result: Result) {
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_PHONE_STATE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            result.error("PERMISSION_DENIED", "READ_PHONE_STATE permission required", null)
            return
        }

        try {
            var phoneNumber: String? = null
            
            // ✅ شيلنا defaultSubscriptionId خالص
            try {
                val telephonyManager = getSystemService(TELEPHONY_SERVICE) as TelephonyManager
                phoneNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    telephonyManager.line1Number
                } else {
                    @Suppress("DEPRECATION")
                    telephonyManager.line1Number
                }
            } catch (e: Exception) {
                phoneNumber = null
            }

            result.success(phoneNumber?.takeIf { it.isNotEmpty() })
            
        } catch (e: Exception) {
            result.error("ERROR", e.message, null)
        }
    }
}