package com.golightyear.adyen_client_side_encryption

import android.annotation.SuppressLint
import androidx.annotation.NonNull
import com.adyen.checkout.cse.CardEncrypter
import com.adyen.checkout.cse.UnencryptedCard

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception
import java.util.Date

/** AdyenClientSideEncryptionPlugin */
class AdyenClientSideEncryptionPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "adyen_client_side_encryption")
    channel.setMethodCallHandler(this)
  }

  @SuppressLint("WrongThread")
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "encryptCard") {
      val card = UnencryptedCard(
        call.argument<String?>("number"),
        call.argument<String?>("expiryMonth"),
        call.argument<String?>("expiryYear"),
        call.argument<String?>("cvc"),
        call.argument<String?>("cardHolderName"),
        Date(),
      );

      try {
        val publicKey = call.argument<String>("publicKey") as String
        val encryptedCardData = CardEncrypter.encryptFields(card, publicKey)
        result.success(mapOf(
          "number" to encryptedCardData.encryptedCardNumber,
          "expiryMonth" to encryptedCardData.encryptedExpiryMonth,
          "expiryYear" to encryptedCardData.encryptedExpiryYear,
          "cvc" to encryptedCardData.encryptedSecurityCode,
        ))
      } catch (e : Exception) {
        result.error("Exception", e.message, e.stackTraceToString())
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
