class UnencryptedCard {
  final String number, expiryMonth, expiryYear, cvc, cardHolderName;

  UnencryptedCard({
    required this.number,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    required this.cardHolderName,
  });
}
