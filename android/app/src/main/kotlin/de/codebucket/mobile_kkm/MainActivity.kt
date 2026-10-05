package de.codebucket.mobile_kkm

import android.content.Intent
import android.content.pm.verify.domain.DomainVerificationManager
import android.content.pm.verify.domain.DomainVerificationUserState
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Flutter's first frame is the same picture as the system splash, so
        // drop the system's fade-out rather than cross-fading into it.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { it.remove() }
        }
        super.onCreate(savedInstanceState)
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

    private companion object {
        const val LINKS_CHANNEL = "de.codebucket.mobile_kkm/links"
    }
}
