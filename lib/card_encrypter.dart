import 'package:adyen_client_side_encryption/encrypted_card.dart';
import 'package:adyen_client_side_encryption/unencrypted_card.dart';

import 'adyen_client_side_encryption_platform_interface.dart';

class CardEncrypter {
  static Future<EncryptedCard> encryptCard(UnencryptedCard card, String publicKey) async {
    final cardDetails = {
      'number': card.number,
      'expiryMonth': card.expiryMonth,
      'expiryYear': card.expiryYear,
      'cvc': card.cvc,
      'cardHolderName': card.cardHolderName,
      'publicKey': publicKey,
    };

    final encryptDetails = await AdyenClientSideEncryptionPlatform.instance.encryptCard(cardDetails);

    return EncryptedCard(
      number: encryptDetails['number'],
      expiryMonth: encryptDetails['expiryMonth'],
      expiryYear: encryptDetails['expiryYear'],
      cvc: encryptDetails['cvc'],
      cardHolderName: encryptDetails['cardHolderName'],
    );
  }
}
