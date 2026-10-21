package de.codebucket.mkkm

import android.app.Activity
import android.content.Intent
import android.os.Bundle

/// Receives tPay's return link (`/payment/success` or `/payment/rejected`)
/// and hands it to MainActivity as an extra, not as the intent's data, so
/// that Flutter's own deep linking never routes it. The browser starts this
/// activity in a task of its own, so NEW_TASK is needed to find the task
/// MainActivity already runs in (its affinity is empty; Android matches it by
/// component); without it a second MainActivity, with a new Flutter engine,
/// would start here. CLEAR_TOP closes the Custom Tab that sits above
/// MainActivity, and SINGLE_TOP hands the link to its onNewIntent.
class PaymentReturnActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val url = intent?.data?.toString()
        if (url != null) {
            startActivity(
                Intent(this, MainActivity::class.java)
                    .putExtra(MainActivity.EXTRA_PAYMENT_RETURN, url)
                    .addFlags(
                        Intent.FLAG_ACTIVITY_NEW_TASK or
                            Intent.FLAG_ACTIVITY_CLEAR_TOP or
                            Intent.FLAG_ACTIVITY_SINGLE_TOP,
                    ),
            )
        }
        finish()
    }
}
