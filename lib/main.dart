import 'package:adyen_client_side_encryption/card_encrypter.dart';
import 'package:adyen_client_side_encryption/unencrypted_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Content(),
    );
  }
}

class Content extends StatefulWidget {
  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String PUBLIC_KEY = throw 'Add your public key here';
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
    CardEncrypter.encryptCard(card, PUBLIC_KEY).then((value) => setState(() => token = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adyen CSE demo'),
      ),
      body: Center(
        child: Text('Card token: $token'),
      ),
    );
  }
}
