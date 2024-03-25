package com.example.eden_app

import android.os.Bundle
import android.util.Log
import android.webkit.WebView
import com.trustlyAndroidLibrary.TrustlyCheckoutAbortHandler
import com.trustlyAndroidLibrary.TrustlyCheckoutErrorHandler
import com.trustlyAndroidLibrary.TrustlyCheckoutSuccessHandler
import com.trustlyAndroidLibrary.TrustlyWebView
import io.flutter.embedding.android.FlutterFragmentActivity
import androidx.appcompat.app.AppCompatActivity;


class TelevisionActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_television)
        val main = findViewById<WebView>(R.id.webview)
        val trustlyView = TrustlyWebView(
            this,
            "<TRUSTLY-URL>"
        )
        main.addView(trustlyView)

//        trustlyView = TrustlyWebView(this, trustlyCheckoutUrl)

        trustlyView.successHandler = TrustlyCheckoutSuccessHandler({
            Log.e("JOSH", "SUCCESS HANDLER")
        })

        trustlyView.errorHandler = TrustlyCheckoutErrorHandler({
            Log.e("JOSH", "ERROR HANDLER")
        })

        trustlyView.abortHandler = TrustlyCheckoutAbortHandler({
            Log.e("JOSH", "ABORT HANDLER")
        })
    }

}