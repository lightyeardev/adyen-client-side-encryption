import 'package:adyen_client_side_encryption/card_encrypter.dart';
import 'package:adyen_client_side_encryption/unencrypted_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String encryptedCardText = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    var publicKey = throw 'Add your public key here';
    var encryptedCard = await CardEncrypter.encryptCard(UnencryptedCard(cvc: '232'), publicKey);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() => encryptedCardText = encryptedCard.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Encrypt card example'),
        ),
        body: Center(
          child: Text('Running on: $encryptedCardText\n'),
        ),
      ),
    );
  }
}
