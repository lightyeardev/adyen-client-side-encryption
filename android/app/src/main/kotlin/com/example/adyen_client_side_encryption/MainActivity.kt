package com.example.adyen_client_side_encryption

import android.annotation.SuppressLint
import androidx.annotation.NonNull
import com.adyen.checkout.cse.CardEncrypter
import com.adyen.checkout.cse.UnencryptedCard
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception
import java.util.*

class MainActivity: FlutterActivity() {

    @SuppressLint("WrongThread")
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "golightyear.com/adyen-cse").setMethodCallHandler {
                call, result ->

            if (call.method == "encryptCard") {
                val card = UnencryptedCard.Builder()
                    .setNumber(call.argument<String>("number") as String)
                    .setExpiryMonth(call.argument<String>("expiryMonth") as String)
                    .setExpiryYear(call.argument<String>("expiryYear") as String)
                    .setCvc(call.argument<String>("cvc") as String)
                    .setHolderName(call.argument<String>("cardHolderName") as String)
                    .setGenerationTime(Date())
                    .build()
                val publicKey = call.argument<String>("publicKey") as String
                try {
                    val encryptedCardData = CardEncrypter.encrypt(card, publicKey)
                    result.success(encryptedCardData)
                } catch (e : Exception) {
                    result.error("Exception", e.message, e.stackTraceToString())
                }
            } else {
                result.notImplemented()
            }
        }
    }
}