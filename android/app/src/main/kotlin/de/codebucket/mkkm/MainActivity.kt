package de.codebucket.mkkm

import android.content.Intent
import android.content.pm.verify.domain.DomainVerificationManager
import android.content.pm.verify.domain.DomainVerificationUserState
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import androidx.browser.customtabs.CustomTabColorSchemeParams
import androidx.browser.customtabs.CustomTabsIntent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var paymentChannel: MethodChannel? = null

    /// A return link that came before Dart could take it: a cold start
    /// after the app was killed during the payment.
    private var pendingReturn: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        // Flutter's first frame is the same picture as the system splash, so
        // drop the system's fade-out rather than cross-fading into it.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { it.remove() }
        }
        super.onCreate(savedInstanceState)
        pendingReturn = intent?.getStringExtra(EXTRA_PAYMENT_RETURN)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val url = intent.getStringExtra(EXTRA_PAYMENT_RETURN) ?: return
        val channel = paymentChannel
        if (channel == null) {
            pendingReturn = url
        } else {
            channel.invokeMethod("returned", url)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LINKS_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "canOpenLinks" -> result.success(canOpenLinks(call.arguments as String))
                    "openLinkSettings" -> {
                        openLinkSettings()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        paymentChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PAYMENT_CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "open" -> {
                        openPayment(
                            call.argument<String>("url")!!,
                            call.argument<Number>("toolbarColor")!!.toInt(),
                        )
                        result.success(null)
                    }
                    // The return link closes the tab; nothing else to close.
                    "close" -> result.success(null)
                    "initialReturn" -> {
                        result.success(pendingReturn)
                        pendingReturn = null
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        paymentChannel?.setMethodCallHandler(null)
        paymentChannel = null
        super.cleanUpFlutterEngine(flutterEngine)
    }

    /// tPay's page in a Custom Tab over the app, in the app's colours, with
    /// its title and without sharing.
    private fun openPayment(url: String, toolbarColor: Int) {
        val colors = CustomTabColorSchemeParams.Builder().setToolbarColor(toolbarColor).build()
        CustomTabsIntent.Builder()
            .setDefaultColorSchemeParams(colors)
            .setShareState(CustomTabsIntent.SHARE_STATE_OFF)
            .setShowTitle(true)
            .build()
            .launchUrl(this, Uri.parse(url))
    }

    /// Whether links to [host] open in this app. Before Android 12 unverified
    /// links simply show the app chooser, so nothing has to be enabled.
    private fun canOpenLinks(host: String): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return true
        val manager = getSystemService(DomainVerificationManager::class.java)
        val state = manager.getDomainVerificationUserState(packageName) ?: return false
        if (!state.isLinkHandlingAllowed) return false
        return when (state.hostToStateMap[host]) {
            DomainVerificationUserState.DOMAIN_STATE_SELECTED,
            DomainVerificationUserState.DOMAIN_STATE_VERIFIED -> true
            else -> false
        }
    }

    private fun openLinkSettings() {
        val action = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            Settings.ACTION_APP_OPEN_BY_DEFAULT_SETTINGS
        } else {
            Settings.ACTION_APPLICATION_DETAILS_SETTINGS
        }
        startActivity(Intent(action, Uri.parse("package:$packageName")))
    }

    companion object {
        private const val LINKS_CHANNEL = "de.codebucket.mkkm/links"
        private const val PAYMENT_CHANNEL = "de.codebucket.mkkm/payment"

        /// The return link, from PaymentReturnActivity.
        const val EXTRA_PAYMENT_RETURN = "de.codebucket.mkkm.PAYMENT_RETURN"
    }
}
