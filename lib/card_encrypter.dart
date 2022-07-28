import 'package:adyen_client_side_encryption/unencrypted_card.dart';
import 'package:flutter/services.dart';

class CardEncrypter {
  static const platform = MethodChannel('golightyear.com/adyen-cse');

  static Future<String> encryptCard(UnencryptedCard card, String publicKey) async {
    final result = await platform.invokeMethod(
      'encryptCard',
      {
        'number': card.number,
        'expiryMonth': card.expiryMonth,
        'expiryYear': card.expiryYear,
        'cvc': card.cvc,
        'cardHolderName': card.cardHolderName,
        'publicKey': publicKey,
      },
    );
    return result as String;
  }
}
