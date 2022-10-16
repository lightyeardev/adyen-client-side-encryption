import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adyen_client_side_encryption_platform_interface.dart';

/// An implementation of [AdyenClientSideEncryptionPlatform] that uses method channels.
class MethodChannelAdyenClientSideEncryption extends AdyenClientSideEncryptionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('adyen_client_side_encryption');

  @override
  Future<Map<String, String?>> encryptCard(Map<String, String?> cardDetails) async {
    return (await methodChannel.invokeMethod<Map>(
      'encryptCard',
      cardDetails,
    ))!.cast<String, String?>();
  }
}
