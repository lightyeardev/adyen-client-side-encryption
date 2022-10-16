class EncryptedCard {
  final String? number, expiryMonth, expiryYear, cvc, cardHolderName;

  EncryptedCard({
    this.number,
    this.expiryMonth,
    this.expiryYear,
    this.cvc,
    this.cardHolderName,
  });

  @override
  String toString() {
    return 'EncryptedCard{number: $number, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvc: $cvc, cardHolderName: $cardHolderName}';
  }
}
