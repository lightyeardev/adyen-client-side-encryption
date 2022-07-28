# Adyen client side encryption

Note: This library is not official from Adyen.

A Flutter plugin to encrypt card details on the client. The encryption is done via the adyen SDK under the hood.

## Example

```
final card = UnencryptedCard(
  number: '123456789',
  expiryMonth: '12',
  expiryYear: '2025',
  cvc: '123',
  cardHolderName: 'John Smith',
);
final encryptedCardToken = await CardEncrypter.encryptCard(card, publicKey);
```
