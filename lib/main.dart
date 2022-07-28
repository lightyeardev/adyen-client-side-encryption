import 'package:adyen_client_side_encryption/card_encrypter.dart';
import 'package:adyen_client_side_encryption/unencrypted_card.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String token = '';

  @override
  void initState() {
    super.initState();

    final card = UnencryptedCard(
      number: '4111111111111111',
      expiryMonth: '3',
      expiryYear: '2020',
      cvc: '737',
      cardHolderName: 'John Smith',
    );
    CardEncrypter.encryptCard(card, publicKey).then((value) => setState(() => token = value));
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0x00ffffff),
      builder: (context, _) => Center(child: Text('Card token: $token')),
    );
  }
}

final String publicKey = throw 'Add your public key here';
